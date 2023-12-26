import 'package:flutter/material.dart';
import 'package:lettutor/features/tutor/tutor_review/widgets/review_card.dart';
import 'package:lettutor/models/tutor/tutor_feedback.dart';
import 'package:lettutor/services/tutor_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/widgets/app_bar.dart';

class TutorReviewScreen extends StatefulWidget {
  const TutorReviewScreen({super.key, required this.tutorId});

  final String tutorId;

  @override
  State<TutorReviewScreen> createState() => _TutorReviewScreenState();
}

class _TutorReviewScreenState extends State<TutorReviewScreen> {
  Future<List<TutorFeedback>>? _feedbacks;

  @override
  void initState() {
    super.initState();
    _getTutorFeedbacks();
  }

  void _getTutorFeedbacks() async {
    await TutorService.getTutorFeedback(
      page: 1,
      perPage: 10,
      userId: widget.tutorId,
      onSuccess: (feedbacks) {
        feedbacks.toList().sort((TutorFeedback late, TutorFeedback old) {
          return old.createdAt.toString().compareTo(late.createdAt.toString());
        });

        setState(() {
          _feedbacks = Future.value(feedbacks);
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
    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: 'Tutor Reviews',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: FutureBuilder(
          future: _feedbacks,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<TutorFeedback> feedbacks =
                  snapshot.data as List<TutorFeedback>;
              return ListView.builder(
                itemCount: feedbacks.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ReviewCard(
                    review: feedbacks[index],
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
