import 'package:flutter/material.dart';
import 'package:lettutor/widgets/lesson_dialog.dart';
import 'package:lettutor/widgets/star_rating.dart';

class HistoryRatingDialog extends StatefulWidget {
  const HistoryRatingDialog({super.key});

  @override
  State<HistoryRatingDialog> createState() => _HistoryRatingDialogState();
}

class _HistoryRatingDialogState extends State<HistoryRatingDialog> {
  final TextEditingController _reviewTextEditingController =
      TextEditingController();
  double _rating = 5;

  @override
  void dispose() {
    super.dispose();
    _reviewTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LessonDialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'What is your rating for Keegan?',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 14),
          StarRating(
            rating: _rating,
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
              decoration: const InputDecoration(
                isCollapsed: true,
                contentPadding: EdgeInsets.all(12),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                ),
                hintText: 'Content Review',
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
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
      onSubmit: () {
        return _rating.toString();
      },
    );
  }
}
