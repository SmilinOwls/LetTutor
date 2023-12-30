import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/utils/media_picker.dart';
import 'package:lettutor/widgets/text/headline_text.dart';
import 'package:lettutor/widgets/text/helper_text.dart';
import 'package:lettutor/widgets/video_player/video_player.dart';
import 'package:video_player/video_player.dart';

class VideoIntroductionStep extends StatefulWidget {
  const VideoIntroductionStep({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  State<VideoIntroductionStep> createState() => _VideoIntroductionStepState();
}

class _VideoIntroductionStepState extends State<VideoIntroductionStep> {
  File? _videoFile;

  void _onVideoUploaded(FormFieldState state) async {
    File? path = await pickerVideo(ImageSource.gallery);

    _videoFile = path;
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
                      'Introduce yourself',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Let students know what they can expect from a lesson with you '
                      'by recording a video highlighting your teaching style, expertise and personality. '
                      'Students can be nervous to speak with a foreigner, so it really helps to have a friendly '
                      'video that introduces yourself and invites students to call you.',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Form(
            key: widget.formKey,
            child: Column(
              children: <Widget>[
                const HeadlineText(textHeadline: 'Introduction video'),
                const SizedBox(height: 12),
                const HelperText(
                  text: 'A few helpful tips: \n'
                      '\t 1. Find a clean and quiet space \n'
                      '\t 2. Smile and look at the camera \n'
                      '\t 3. Dress smart \n'
                      '\t 4. Speak for 1-3 minutes \n'
                      '\t 5. Brand yourself and have fun!\n',
                  warningText:
                      'Note: We only support uploading video file that is less than 64 MB in size.',
                ),
                const SizedBox(height: 12),
                FormField(
                  builder: (FormFieldState state) => Column(
                    children: <Widget>[
                      OutlinedButton(
                        onPressed: () {
                          _onVideoUploaded(state);
                        },
                        child: const Text('Choose Video'),
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
                      return 'Please input your video';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                if (_videoFile != null)
                  VideoPlayerView(
                    url: _videoFile?.path ?? '',
                    dataSourceType: DataSourceType.file,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
