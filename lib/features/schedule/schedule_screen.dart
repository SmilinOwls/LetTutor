import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/features/schedule/widgets/schedule_card.dart';
import 'package:lettutor/models/schedule/booking_info.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:lettutor/utils/snack_bar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  Future<List<BookingInfo>>? _bookings;

  @override
  void initState() {
    super.initState();
    _getBookingListByStudent();
  }

  void _getBookingListByStudent() async {
    await BookingService.getBookingListByStudent(
      page: 1,
      perPage: 10,
      onSuccess: (bookings) {
        setState(() {
          _bookings = Future.value(bookings);
        });
      },
      onError: (message) => SnackBarHelper.showErrorSnackBar(
        context: context,
        content: message,
      ),
    );
  }

  void _updateBookingListAfterCanceling(BookingInfo booking) {
    setState(() {
      _bookings = _bookings!.then((bookings) {
        bookings.remove(booking);
        return bookings;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl:
                'https://sandbox.app.lettutor.com/static/media/calendar-check.7cf3b05d.svg',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(
              Icons.calendar_month_rounded,
              size: 62,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Schedule',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          const Text(
            'Here is a list of the sessions you have booked\n'
            'You can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 4),
          const Divider(height: 1),
          const SizedBox(height: 16),
          FutureBuilder(
            future: _bookings,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<BookingInfo> bookings =
                    snapshot.data as List<BookingInfo>;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    return ScheduleCard(
                      booking: bookings[index],
                      onCancel: _updateBookingListAfterCanceling,
                    );
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
