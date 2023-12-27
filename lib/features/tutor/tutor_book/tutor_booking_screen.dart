import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/features/tutor/tutor_book/widgets/tutor_booking_hour_dialog.dart';
import 'package:lettutor/models/schedule/schedule.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/widgets/app_bar.dart';

class TutorBookingScreen extends StatefulWidget {
  const TutorBookingScreen({super.key, required this.tutorId});

  final String tutorId;

  @override
  State<TutorBookingScreen> createState() => _TutorBookingScreenState();
}

class _TutorBookingScreenState extends State<TutorBookingScreen> {
  Map<String, List<Schedule>>? _tutorSchedules;

  @override
  void initState() {
    super.initState();
    getTutorSchedule();
  }

  void getTutorSchedule() async {
    await BookingService.getTutorScheduleById(
      tutorId: widget.tutorId,
      onSuccess: (schedules) {
        _tutorScheduleHandle(schedules);
      },
      onError: (message) => SnackBarHelper.showErrorSnackBar(
        context: context,
        content: message,
      ),
    );
  }

  void _tutorScheduleHandle(List<Schedule> schedules) {
    schedules.removeWhere(
      (schedule) =>
          DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp ?? 0)
              .isBefore(DateTime.now()),
    );
    schedules.sort((schedule1, schedule2) =>
        schedule1.startTimestamp!.compareTo(schedule2.startTimestamp!));

    setState(() {
      for (var schedule in schedules) {
        final date =
            DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp!);
        final dateKey = DateFormat('yyyy-MM-dd').format(date);
        _tutorSchedules ??= <String, List<Schedule>>{};
        if (_tutorSchedules?[dateKey] == null) {
          _tutorSchedules?[dateKey] = [];
        }
        _tutorSchedules?[dateKey]?.add(schedule);
      }
    });
  }

  void _updateBookingDateStatus(String date, Schedule schedule) {
    setState(() {
      _tutorSchedules?[date]
          ?.firstWhere((element) => element.id == schedule.id)
          .isBooked = true;
    });
  }

  Future<void> _showTutorBookingTimeDialog(
      MapEntry<String, List<Schedule>>? dateSchedules) async {
    await showModalBottomSheet(
      elevation: 3,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      context: context,
      builder: (context) =>
          TutorBookingHourDialog(dateSchedules: dateSchedules, onBooked: _updateBookingDateStatus),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _tutorSchedules == null
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: const CustomAppBar(
              appBarTitle: 'Tutor Booking',
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 20,
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    'Choose Learning Date',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    fit: FlexFit.tight,
                    child: GridView.builder(
                        itemCount: _tutorSchedules?.length ?? 0,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 18,
                          crossAxisSpacing: 28,
                          childAspectRatio: 4,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final isFullBookingDate = _tutorSchedules?.entries
                              .elementAt(index)
                              .value
                              .every((schedule) => schedule.isBooked == true);

                          if (isFullBookingDate == false) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[300],
                              ),
                              onPressed: () {
                                _showTutorBookingTimeDialog(
                                    _tutorSchedules?.entries.elementAt(index));
                              },
                              child: Text(
                                _tutorSchedules?.keys.elementAt(index) ?? '',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            );
                          } else {
                            return ElevatedButton(
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style
                                  ?.copyWith(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.grey[500],
                                    ),
                                  ),
                              onPressed: () {},
                              child: Text(
                                _tutorSchedules?.keys.elementAt(index) ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          );
  }
}

// List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
//   List<DateTime> days = [];
//   for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
//     days.add(DateTime(startDate.year, startDate.month, startDate.day + i));
//   }
//   return days;
// }
