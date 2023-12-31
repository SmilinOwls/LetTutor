import 'package:flutter/material.dart';
import 'package:lettutor/features/tutor/tutor_review/widgets/review_card.dart';
import 'package:lettutor/models/tutor/tutor_feedback.dart';
import 'package:lettutor/services/tutor_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/widgets/bar/app_bar.dart';
import 'package:pager/pager.dart';

class TutorReviewScreen extends StatefulWidget {
  const TutorReviewScreen({super.key, required this.tutorId});

  final String tutorId;

  @override
  State<TutorReviewScreen> createState() => _TutorReviewScreenState();
}

class _TutorReviewScreenState extends State<TutorReviewScreen> {
  Future<List<TutorFeedback>>? _feedbacks;
  int _page = 1;
  final int _perPage = 10;
  late int _totalPages;

  @override
  void initState() {
    super.initState();
    _getTutorFeedbacks();
  }

  void _getTutorFeedbacks() async {
    await TutorService.getTutorFeedback(
      page: _page,
      perPage: _perPage,
      userId: widget.tutorId,
      onSuccess: (totalItems, feedbacks) {
        feedbacks.toList().sort((TutorFeedback late, TutorFeedback old) {
          return old.createdAt.toString().compareTo(late.createdAt.toString());
        });

        setState(() {
          _totalPages = (totalItems / _perPage).ceil();
          _feedbacks = Future.value(feedbacks);
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
    });
    _getTutorFeedbacks();
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
              return Column(
                children: <Widget>[
                  ListView.builder(
                    itemCount: feedbacks.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ReviewCard(
                        review: feedbacks[index],
                      );
                    },
                  ),
                  Pager(
                    currentItemsPerPage: _perPage,
                    currentPage: _page,
                    totalPages: _totalPages,
                    onPageChanged: _onPageChanged,
                  )
                ],
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
