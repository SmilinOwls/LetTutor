import 'package:flutter/material.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/models/tutor/tutor.dart';
import 'package:lettutor/widgets/start_rating.dart';
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
        surfaceTintColor: Colors.white,
        elevation: 6,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () =>
                          Navigator.of(context).pushNamed(Routes.login),
                      child: Container(
                          width: 82,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(widget.tutor.avatar!),
                                fit: BoxFit.contain),
                          ),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage: AssetImage(widget.tutor.avatar!),
                          ))),
                  const SizedBox(width: 18),
                  Flexible(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () =>
                            Navigator.of(context).pushNamed(Routes.login),
                        child: Text(widget.tutor.name ?? 'null name',
                            style: Theme.of(context).textTheme.displaySmall),
                      ),
                      const SizedBox(height: 8),
                      Text(widget.tutor.country ?? 'null country',
                          style: const TextStyle(fontSize: 16)),
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
                  )),
                  IconButton(
                      onPressed: () {},
                      icon: ([true, false]..shuffle()).first
                          ? const Icon(
                              Icons.favorite_rounded,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border_rounded,
                              color: Colors.blue,
                            ))
                ],
              ),
              const SizedBox(height: 10),
              TagChip(specialties: widget.tutor.specialties),
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
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.edit_calendar,
                        color: Theme.of(context).primaryColor),
                    const SizedBox(width: 6),
                    Text('Book',
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)),
                  ]),
                ),
              )
            ],
          ),
        ));
  }
}
