import 'package:flutter/material.dart';
import 'package:lettutor/constants/dto/tutor/tutor_feedback.dart';
import 'package:lettutor/features/tutor/tutor_review/widgets/review_card.dart';
import 'package:lettutor/widgets/app_bar.dart';

class TutorReviewScreen extends StatefulWidget {
  const TutorReviewScreen({super.key, required this.feedbacks});

  final List<TutorFeedback> feedbacks;

  @override
  State<TutorReviewScreen> createState() => _TutorReviewScreenState();
}

class _TutorReviewScreenState extends State<TutorReviewScreen> {
  @override
  Widget build(BuildContext context) {
    final reviews = widget.feedbacks;

    reviews.toList().sort((TutorFeedback late, TutorFeedback old) {
      return old.createdAt.toString().compareTo(late.createdAt.toString());
    });

    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: 'Tutor Reviews',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: ListView.builder(
            itemCount: reviews.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => ReviewCard(review: reviews[index]),
          ),
        ),
      ),
    );
  }
}
