import 'package:flutter/material.dart';
import 'package:lettutor/constants/dto/tutor/tutor_feedback.dart';
import 'package:lettutor/utils/time_diff.dart';
import 'package:lettutor/widgets/star_rating.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final TutorFeedback review;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () {},
              child: Container(
                width: 62,
                height: 62,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/avatar/user/user_avatar.jpeg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.person_outline_rounded,
                      size: 62,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 18),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        review.username ?? 'null name',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        TimeDiff.timeAgo(review.createdAt!),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  StarRating(rating: review.rating ?? 0),
                  const SizedBox(height: 4),
                  Text(review.content ?? 'null content'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
