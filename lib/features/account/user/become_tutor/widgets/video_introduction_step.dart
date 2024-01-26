import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/models/injection/injection.dart';
import 'package:lettutor/models/tutor/tutor_become.dart';
import 'package:lettutor/utils/media_picker.dart';
import 'package:lettutor/widgets/text/headline_text.dart';
import 'package:lettutor/widgets/text/helper_text.dart';
import 'package:lettutor/widgets/video_player/video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VideoIntroductionStep extends StatefulWidget {
  const VideoIntroductionStep({
    super.key,
    required this.formKey,
    required this.videoFile,
    required this.onFileChanged,
  });

  final GlobalKey<FormState> formKey;
  final File? videoFile;
  final void Function(File?) onFileChanged;

  @override
  State<VideoIntroductionStep> createState() => _VideoIntroductionStepState();
}

class _VideoIntroductionStepState extends State<VideoIntroductionStep> {
  File? _videoFile;
  late AppLocalizations _local;
  TutorBecome tutorBecome = getIt.get<TutorBecome>();

  @override
  void initState() {
    super.initState();
    _videoFile = widget.videoFile;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context);
  }

  void _onVideoUploaded(FormFieldState state) async {
    File? path = await pickerVideo(ImageSource.gallery);

    _videoFile = path;
    tutorBecome.video = path;
    widget.onFileChanged(_videoFile);
    state.didChange(_videoFile);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SvgPicture.asset(
                  'assets/misc/profile_intro.svg',
                  height: 100,
                  alignment: Alignment.topCenter,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _local.introduceYourself,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 8),
                    Text(_local.introduceYourselfDescription),
                  ],
                ),
              ),
            ],
          ),
          Form(
            key: widget.formKey,
            child: Column(
              children: <Widget>[
                HeadlineText(textHeadline: _local.videoIntroduction),
                const SizedBox(height: 12),
                HelperText(
                  text: _local.helpfulTips,
                  warningText: _local.introVideoWarning,
                ),
                const SizedBox(height: 12),
                FormField(
                  builder: (FormFieldState state) => Column(
                    children: <Widget>[
                      OutlinedButton(
                        onPressed: () {
                          _onVideoUploaded(state);
                        },
                        child: Text(_local.chooseVideo),
                      ),
                      if (_videoFile != null)
                        VideoPlayerView(
                          key: ValueKey(_videoFile!.path),
                          url: _videoFile!.path,
                          dataSourceType: DataSourceType.file,
                        ),
                      if (state.hasError)
                        Text(
                          state.errorText!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                    ],
                  ),
                  validator: (value) {
                    if (_videoFile == null) {
                      return _local.chooseVideoValidator;
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
