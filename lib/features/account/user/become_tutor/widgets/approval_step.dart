import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor/models/injection/injection.dart';
import 'package:lettutor/models/tutor/tutor_become.dart';
import 'package:lettutor/services/tutor_service.dart';
import 'package:lettutor/utils/snack_bar.dart';

class ApprovalStep extends StatefulWidget {
  const ApprovalStep({super.key});

  @override
  State<ApprovalStep> createState() => _ApprovalStepState();
}

class _ApprovalStepState extends State<ApprovalStep> {
  late AppLocalizations _local;
  TutorBecome tutorBecome = getIt.get<TutorBecome>();
  bool isRegistering = false;
  Future<bool>? isRegisterSuccess;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context)!;
  }

  void _registerTutor() async {
    final info = tutorBecome.toJson();
    await TutorService.becomeATutor(
      info: info,
      onSuccess: (user) {
        setState(() {
          isRegisterSuccess = Future.value(true);
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
    return isRegistering == false ?
    TextButton(
      onPressed: () {
        _registerTutor();
      },
      child: Text(_local.registerTutor),
    )
    : FutureBuilder(
      future: isRegisterSuccess,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            return Column(
              children: <Widget>[
                Icon(
                  Icons.tag_faces_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 100,
                ),
                const SizedBox(height: 16),
                Text(_local.allStepsDone),
                const SizedBox(height: 8),
                Text(_local.waitForApproval),
              ],
            );
          } else {
            // try again
            return TextButton(
              onPressed: () {
                _registerTutor();
              },
              child: Text(_local.tryAgain),
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
