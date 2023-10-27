import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/tutor/tutor_detail/widgets/tutor_report_dialog.dart';
import 'package:lettutor/widgets/app_bar.dart';
import 'package:lettutor/widgets/star_rating.dart';
import 'package:lettutor/widgets/tag_chip.dart';

class TutorDetailScreen extends StatefulWidget {
  const TutorDetailScreen({super.key});

  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  final tutor = tutors[0];

  Future<void> _showReportDialog() async {
    await showDialog(
            context: context, builder: (context) => const TutorReportDiaglog())
        .then((response) async {
      if (response) {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: const Text('Report Successfully!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: Colors.blue[700]),
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appBarLeading: true,
        appBarTitle: 'Tutor Details',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Container(
                    width: 92,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage(tutor.avatar!),
                      onBackgroundImageError: (exception, stackTrace) =>
                          const Icon(Icons.person_outline_rounded, size: 62),
                    )),
                const SizedBox(width: 18),
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tutor.name ?? 'null name',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: tutor.rating != null
                          ? Row(
                              children: [
                                StarRating(rating: tutor.rating!),
                                const SizedBox(width: 4),
                                Text('(${tutor.ratingNo})',
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                    )),
                              ],
                            )
                          : const Text(
                              'No reviews yet',
                              style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                    ),
                    const SizedBox(height: 8),
                    Text(tutor.country ?? 'null country',
                        style: const TextStyle(fontSize: 16)),
                  ],
                )),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              tutor.bio ?? 'null bio',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: TextButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        [true, false].first
                            ? const Icon(
                                Icons.favorite_rounded,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border_rounded,
                                color: Colors.blue,
                              ),
                        const SizedBox(height: 4),
                        Text(
                          'Favorite',
                          style: TextStyle(
                            color:
                                [true, false].first ? Colors.red : Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: TextButton(
                    onPressed: _showReportDialog,
                    child: const Column(
                      children: [
                        Icon(Icons.report_outlined, color: Colors.blue),
                        SizedBox(height: 4),
                        Text('Report', style: TextStyle(color: Colors.blue))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              alignment: Alignment.center,
              height: 280,
              child: const Text(
                'No Intro video available',
              ),
            ),
            const SizedBox(height: 8),
            Text('Education', style: Theme.of(context).textTheme.bodyLarge),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                tutor.education ?? 'No education',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 8),
            Text('Languages', style: Theme.of(context).textTheme.bodyLarge),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: TagChip(tags: tutor.languages),
            ),
            const SizedBox(height: 8),
            Text('Specialties', style: Theme.of(context).textTheme.bodyLarge),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: TagChip(tags: tutor.specialties),
            ),
            const SizedBox(height: 8),
            Text('Suggested Courses',
                style: Theme.of(context).textTheme.bodyLarge),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Column(
                  children: List<Widget>.generate(
                      courses.getRange(0, 2).length,
                      (index) => (Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(children: [
                              Text('${courses[index].name}',
                                  style: Theme.of(context).textTheme.bodyLarge),
                              const SizedBox(width: 6),
                              InkWell(
                                  onTap: () {},
                                  child: const Text('Link',
                                      style: TextStyle(color: Colors.blue)))
                            ]),
                          ))),
                )),
            const SizedBox(height: 8),
            Text('Interests', style: Theme.of(context).textTheme.bodyLarge),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                tutor.interests ?? 'No interests',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 8),
            Text('Teaching experience',
                style: Theme.of(context).textTheme.bodyLarge),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                tutor.experience ?? 'No teaching experiences',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
