import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/features/tutor/tutor_book/tutor_booking_screen.dart';
import 'package:lettutor/features/tutor/tutor_detail/widgets/tutor_report_dialog.dart';
import 'package:lettutor/features/tutor/tutor_review/tutor_review_screen.dart';
import 'package:lettutor/models/tutor/tutor_info.dart';
import 'package:lettutor/services/tutor_service.dart';
import 'package:lettutor/services/user_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/widgets/bar/app_bar.dart';
import 'package:lettutor/widgets/star_rating/star_rating.dart';
import 'package:lettutor/widgets/chip/tag_chip.dart';
import 'package:lettutor/widgets/video_player/video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorDetailScreen extends StatefulWidget {
  const TutorDetailScreen({super.key});

  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  TutorInfo? _tutor;
  bool _isFavorite = false;
  final Map<String, List<String>> _tags = {
    'languages': [],
    'specialities': [],
  };

  late AppLocalizations _local;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getTutorInfo();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context);
  }

  void _getTutorInfo() async {
    final arguments = ModalRoute.of(context)!.settings.arguments as String?;

    final String userId = arguments ?? '';

    await TutorService.getTutorInfoById(
      userId: userId,
      onSuccess: (tutorInfo) {
        _tutor = tutorInfo;
        _handleDataConvert(tutorInfo);
      },
      onError: (message) => SnackBarHelper.showErrorSnackBar(
        context: context,
        content: message,
      ),
    );
  }

  void _handleFavorite(String userId) async {
    await UserService.handleFavorite(
      userId: userId,
      onSuccess: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
        SnackBarHelper.showSuccessSnackBar(
          context: context,
          content: _isFavorite
              ? _local.succesAddFavoriteTutor
              : _local.successRemoveFavoriteTutor,
        );
      },
      onError: (message) => SnackBarHelper.showErrorSnackBar(
        context: context,
        content: message,
      ),
    );
  }

  void _handleDataConvert(TutorInfo tutorInfo) {
    final List<String> languageList = tutorInfo.languages?.split(',') ?? [];
    final List<String> specialityList = tutorInfo.specialties?.split(',') ?? [];

    _tags['languages'] = languageList
        .map((language) => worldLanguages[language] ?? language)
        .toList();
    _tags['specialities'] = <String>[
      for (final speciality in specialityList)
        specialities.where((element) => element.key == speciality).isNotEmpty
            ? specialities
                .firstWhere((element) => element.key == speciality)
                .name!
            : speciality
    ];
    _isFavorite = tutorInfo.isFavorite ?? false;
    setState(() {});
  }

  Future<void> _showReportDialog() async {
    await showDialog(
      context: context,
      builder: (context) => TutorReportDialog(
        tutorId: _tutor?.user?.id ?? '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: _local.tutorDetail,
      ),
      body: _tutor == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 92,
                          height: 92,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: _tutor?.user?.avatar ?? '',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 72,
                            ),
                            errorWidget: (context, error, stackTrace) =>
                                const Icon(
                              Icons.error_outline_rounded,
                              color: Colors.red,
                              size: 92,
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Flexible(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _tutor?.user?.name ?? '',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: _tutor?.rating != null
                                  ? Row(
                                      children: <Widget>[
                                        StarRating(rating: _tutor?.rating ?? 0),
                                        const SizedBox(width: 4),
                                        Text(
                                          '(${_tutor?.totalFeedback ?? 0})',
                                          style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      _local.nullReviews,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              countryList[_tutor?.user?.country] ??
                                  _tutor?.user?.country ??
                                  _local.nullCountry,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _tutor?.bio ?? _local.nullBio,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextButton(
                            onPressed: () {
                              _handleFavorite(_tutor?.user?.id ?? '');
                            },
                            child: Column(
                              children: <Widget>[
                                _isFavorite
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
                                  _local.favorite,
                                  style: TextStyle(
                                    color:
                                        _isFavorite ? Colors.red : Colors.blue,
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
                            child: Column(
                              children: <Widget>[
                                const Icon(Icons.report_outlined, color: Colors.blue),
                                const SizedBox(height: 4),
                                Text(
                                  _local.report,
                                  style: const TextStyle(color: Colors.blue),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TutorReviewScreen(
                                    tutorId: _tutor?.user?.id ?? 'null id',
                                  ),
                                ),
                              );
                            },
                            child:  Column(
                              children: <Widget>[
                                const Icon(
                                  Icons.reviews_outlined,
                                  color: Colors.blue,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _local.reviews,
                                  style: const TextStyle(color: Colors.blue),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    VideoPlayerView(
                      url: _tutor?.video ?? '',
                      dataSourceType: DataSourceType.network,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _local.education,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      child: Text(
                        _tutor?.education ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _local.languages,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      child: TagChip(tags: _tags['languages'] ?? []),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _local.specialties,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      child: TagChip(tags: _tags['specialities'] ?? []),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _local.suggestedCourses,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      child: Column(
                        children: _tutor?.user?.courses
                                ?.map<Widget>(
                                  (course) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      children: <Widget>[
                                        Text('${course.name}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                        const SizedBox(width: 6),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              Routes.courseDetail,
                                              arguments: course.id,
                                            );
                                          },
                                          child: Text(
                                            _local.link,
                                            style: const TextStyle(
                                                color: Colors.blue),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                                .toList() ??
                            [],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _local.interests,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      child: Text(
                        _tutor?.interests ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _local.teachingExperience,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      child: Text(
                        _tutor?.experience ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TutorBookingScreen(
                                tutorId: _tutor?.user?.id ?? '',
                              ),
                            ),
                          );
                        },
                        child: Text(
                          _local.bookNow,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
