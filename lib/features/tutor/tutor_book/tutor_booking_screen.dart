import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/features/tutor/tutor_book/widgets/tutor_booking_hour_dialog.dart';
import 'package:lettutor/models/schedule/schedule.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:lettutor/utils/localization.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/utils/time_helper.dart';
import 'package:lettutor/widgets/bar/app_bar.dart';
import 'package:lettutor/widgets/pagination/pagination.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorBookingScreen extends StatefulWidget with Localization {
  const TutorBookingScreen({super.key, required this.tutorId});

  final String tutorId;

  @override
  State<TutorBookingScreen> createState() => _TutorBookingScreenState();
}

class _TutorBookingScreenState extends State<TutorBookingScreen> {
  Map<String, List<Schedule>>? _tutorSchedules;
  int _currentPage = 1;
  DateTime _date = DateTime.now();
  late AppLocalizations local;

  @override
  void initState() {
    super.initState();
    _getTutorSchedule();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    local = Localization.local!;
  }

  void _getTutorSchedule() async {
    await BookingService.getTutorScheduleById(
      tutorId: widget.tutorId,
      page: _currentPage - 1,
      onSuccess: (schedules) {
        _tutorScheduleHandle(schedules);
      },
      onError: (message) => SnackBarHelper.showErrorSnackBar(
        context: context,
        content: message,
      ),
    );
  }

  void _onPageChanged(int page) {
    _date = DateTime.now().add(Duration(days: (page - 1) * 7));
    setState(() {
      _currentPage = page;
    });
    _getTutorSchedule();
  }

  void _tutorScheduleHandle(List<Schedule> schedules) {
    if (schedules.isEmpty) {
      setState(() {
        _tutorSchedules = {};
      });
      return;
    }

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
      builder: (context) => TutorBookingHourDialog(
          dateSchedules: dateSchedules, onBooked: _updateBookingDateStatus),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: local.tutorBooking,
      ),
      body: _tutorSchedules == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        local.chooseLearningDate,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        TimeHelper.getMostRecentWeekRangeFromDate(_date),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 18),
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
                                  .every(
                                      (schedule) => schedule.isBooked == true);

                              if (isFullBookingDate == false) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[300],
                                  ),
                                  onPressed: () {
                                    _showTutorBookingTimeDialog(_tutorSchedules
                                        ?.entries
                                        .elementAt(index));
                                  },
                                  child: Text(
                                    _tutorSchedules?.keys.elementAt(index) ??
                                        '',
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
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.grey[500],
                                        ),
                                      ),
                                  onPressed: () {},
                                  child: Text(
                                    _tutorSchedules?.keys.elementAt(index) ??
                                        '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }
                            }),
                      ),
                      Pagination(onPageChanged: _onPageChanged),
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
