import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/features/schedule/widgets/schedule_card.dart';
import 'package:lettutor/models/schedule/booking_info.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:pager/pager.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  Future<List<BookingInfo>>? _bookings;

  int _page = 1;
  final int _perPage = 20;
  late int _totalPages;

  @override
  void initState() {
    super.initState();
    _getBookingListByStudent();
  }

  void _getBookingListByStudent() async {
    await BookingService.getBookingListByStudent(
      page: _page,
      perPage: _perPage,
      onSuccess: (total, bookings) {
        setState(() {
          _totalPages = (total / _perPage).ceil();
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

  void _onPageChanged(int page) {
    setState(() {
      _page = page;
      _bookings = null;
    });
    _getBookingListByStudent();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
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
                if (bookings.isEmpty) {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'There is no lesson schedule yet!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Book a lesson'),
                        ),
                      ],
                    ),
                  );
                }
                return Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Total prescheduled lessons: ${bookings.length}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Pager(
                      currentItemsPerPage: _perPage,
                      currentPage: _page,
                      totalPages: _totalPages,
                      onPageChanged: _onPageChanged,
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        return ScheduleCard(
                          booking: bookings[index],
                          onCancel: _updateBookingListAfterCanceling,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Pager(
                      currentItemsPerPage: _perPage,
                      currentPage: _page,
                      totalPages: _totalPages,
                      onPageChanged: _onPageChanged,
                    ),
                  ],
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
