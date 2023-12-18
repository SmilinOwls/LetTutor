import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/models/tutor/tutor.dart';
import 'package:lettutor/widgets/star_rating.dart';
import 'package:lettutor/widgets/tag_chip.dart';

class TutorCard extends StatefulWidget {
  const TutorCard({super.key, required this.tutor});

  final Tutor tutor;

  @override
  State<TutorCard> createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed(Routes.tutorDetail),
                  child: Container(
                    width: 72,
                    height: 72,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.tutor.avatar ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 72,
                      ),
                      errorWidget: (context, error, stackTrace) => const Icon(
                        Icons.error_outline_rounded,
                        color: Colors.red,
                        size: 72,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () =>
                            Navigator.of(context).pushNamed(Routes.tutorDetail),
                        child: Text(widget.tutor.name ?? 'null name',
                            style: Theme.of(context).textTheme.displaySmall),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        countryList[widget.tutor.country] ??
                            widget.tutor.country ??
                            'null country',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      widget.tutor.rating != null
                          ? StarRating(rating: widget.tutor.rating!)
                          : const Text(
                              'No reviews yet',
                              style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: ([true, false]).first
                      ? const Icon(
                          Icons.favorite_rounded,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.blue,
                        ),
                )
              ],
            ),
            const SizedBox(height: 10),
            TagChip(tags: widget.tutor.specialties?.split(',') ?? []),
            const SizedBox(height: 10),
            Text(
              widget.tutor.bio ?? 'null',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.edit_calendar,
                        color: Theme.of(context).primaryColor),
                    const SizedBox(width: 6),
                    Text(
                      'Book',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
