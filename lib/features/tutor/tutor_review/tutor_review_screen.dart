import 'package:flutter/material.dart';
import 'package:lettutor/features/tutor/tutor_review/widgets/review_card.dart';
import 'package:lettutor/models/tutor/tutor_feedback.dart';
import 'package:lettutor/widgets/app_bar.dart';

class TutorReviewScreen extends StatefulWidget {
  const TutorReviewScreen({super.key});

  @override
  State<TutorReviewScreen> createState() => _TutorReviewScreenState();
}

class _TutorReviewScreenState extends State<TutorReviewScreen> {
  @override
  Widget build(BuildContext context) {
    final reviews =
        ModalRoute.of(context)?.settings.arguments as List<TutorFeedback>;

    return Scaffold(
        appBar: const CustomAppBar(
          appBarLeading: true,
          appBarTitle: 'Tutor Reviews',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: ListView.builder(
              itemCount: reviews.length,
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  ReviewCard(review: reviews[index]),
            ),
          ),
        ));
  }
}
