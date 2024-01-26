import 'package:flutter/material.dart';
import 'package:lettutor/models/schedule/booking_info.dart';
import 'package:lettutor/models/tutor/tutor_feedback.dart';
import 'package:lettutor/services/user_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/widgets/dialog/lesson_dialog.dart';
import 'package:lettutor/widgets/star_rating/star_rating.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryRatingDialog extends StatefulWidget {
  const HistoryRatingDialog({super.key, required this.booking, this.feedback});

  final BookingInfo booking;
  final TutorFeedback? feedback;

  @override
  State<HistoryRatingDialog> createState() => _HistoryRatingDialogState();
}

class _HistoryRatingDialogState extends State<HistoryRatingDialog> {
  final TextEditingController _reviewTextEditingController =
      TextEditingController();
  double? _rating;

  late final BookingInfo booking;
  late AppLocalizations _local;
  
  @override
  void initState() {
    super.initState();
    booking = widget.booking;
    _rating = widget.feedback?.rating?.toDouble();
    _reviewTextEditingController.text = widget.feedback?.content ?? '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context);
  }

  Future<String?> _handleRatingSubmit() async {
    final response = await UserService.feedbackTutor(
      bookingId: booking.id ?? '',
      userId: booking.userId ?? '',
      rating: _rating?.toInt() ?? 0,
      content: _reviewTextEditingController.text,
      onSuccess: () {
        return _rating.toString();
      },
      onError: (message) {
        SnackBarHelper.showErrorSnackBar(
          context: context,
          content: message,
        );
      },
    );

    return response;
  }

  @override
  void dispose() {
    super.dispose();
    _reviewTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LessonDialog(
      booking: booking,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            _local.tutorRatingTitle(booking.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.name ?? ''),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 14),
          StarRating(
            rating: _rating ?? 0,
            onRatingChanged: (value) => setState(() {
              _rating = value;
            }),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            child: TextField(
              maxLines: null,
              expands: true,
              controller: _reviewTextEditingController,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {},
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: const EdgeInsets.all(12),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                ),
                hintText: _local.contentReviewHint,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      onSubmit: () async {
        return await _handleRatingSubmit();
      },
    );
  }
}
