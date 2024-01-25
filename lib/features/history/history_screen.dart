import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/features/history/widgets/history_card.dart';
import 'package:lettutor/models/schedule/booking_info.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:pager/pager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future<List<BookingInfo>>? _bookings;
  late AppLocalizations _local;

  int _page = 1;
  final int _perPage = 20;
  late int _totalPages;

  @override
  void initState() {
    super.initState();
    _getBookingListByStudent();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context);
  }

  void _getBookingListByStudent() async {
    await BookingService.getBookingListByStudent(
      page: _page,
      perPage: _perPage,
      inFuture: 0,
      sortBy: 'desc',
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
            _local.history,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          Text(
            _local.historyDescription,
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
                        Text(
                          _local.noLessonHistory,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(_local.bookLesson),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
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
                        return HistoryCard(
                          booking: bookings[index],
                          onUpdatedBooking: _getBookingListByStudent,
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
