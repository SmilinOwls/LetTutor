import 'package:flutter/material.dart';
import 'package:lettutor/features/tutor/tutor_book/widgets/tutor_booking_confirm_dialog.dart';
import 'package:lettutor/models/schedule/schedule.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/utils/time_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorBookingHourDialog extends StatefulWidget {
  const TutorBookingHourDialog(
      {super.key, this.dateSchedules, required this.onBooked});

  final MapEntry<String, List<Schedule>>? dateSchedules;
  final void Function(String, Schedule) onBooked;

  @override
  State<TutorBookingHourDialog> createState() => _TutorBookingHourDialogState();
}

class _TutorBookingHourDialogState extends State<TutorBookingHourDialog> {
  late AppLocalizations _local;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context)!;
  }

  Future<void> _showTutorBookingConfirmDialog(Schedule detailSchedule) async {
    await showDialog(
      context: context,
      builder: (context) => TutorBookingConfirmDialog(schedule: detailSchedule),
    ).then((value) {
      if (value == true) {
        widget.onBooked(widget.dateSchedules?.key ?? '', detailSchedule);
        SnackBarHelper.showSuccessSnackBar(
          context: context,
          content: _local.successBookTutor,
        );
      }
      if (value == false) {
        SnackBarHelper.showErrorSnackBar(
          context: context,
          content: _local.failBookTutor,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String tutorDateSchedule = widget.dateSchedules?.key ?? '';
    final List<Schedule> tutorDetailSchedule =
        widget.dateSchedules?.value ?? [];

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            _local.bookingTime,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 6),
          Text(
            _local.onTime(tutorDateSchedule),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 12),
          Flexible(
            fit: FlexFit.tight,
            child: GridView.builder(
              itemCount: tutorDetailSchedule.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 18,
                crossAxisSpacing: 28,
                childAspectRatio: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (tutorDetailSchedule[index].isBooked == false) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[300],
                    ),
                    onPressed: () {
                      _showTutorBookingConfirmDialog(
                          tutorDetailSchedule[index]);
                    },
                    child: Text(
                      '${TimeHelper.convertTimeStampToHour(tutorDetailSchedule[index].startTimestamp ?? 0)}'
                      '-'
                      '${TimeHelper.convertTimeStampToHour(tutorDetailSchedule[index].endTimestamp ?? 0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  );
                } else {
                  return ElevatedButton(
                    style:
                        Theme.of(context).elevatedButtonTheme.style?.copyWith(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.grey[500],
                              ),
                            ),
                    onPressed: null,
                    child: Text(
                      '${TimeHelper.convertTimeStampToHour(tutorDetailSchedule[index].startTimestamp ?? 0)}'
                      '-'
                      '${TimeHelper.convertTimeStampToHour(tutorDetailSchedule[index].endTimestamp ?? 0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
