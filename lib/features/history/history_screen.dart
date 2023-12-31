import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/features/history/widgets/history_card.dart';
import 'package:lettutor/models/schedule/booking_info.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:lettutor/utils/snack_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
      inFuture: 0,
      sortBy: 'desc',
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl:
                'https://sandbox.app.lettutor.com/static/media/history.1e097d10.svg',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(
              Icons.phone_callback_outlined,
              size: 62,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'History',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          const Text(
            'The following is a list of lessons you have attended\n'
            'You can review the details of the lessons you have attended',
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
                      children: [
                        const Text(
                          'You have no history',
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

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    return HistoryCard(
                      booking: bookings[index],
                      onUpdatedBooking: _getBookingListByStudent,
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
