import 'package:flutter/material.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/services/auth_service.dart';
import 'package:lettutor/utils/field_validate.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/widgets/bar/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  String? _emailErrorText;

  late AppLocalizations _local;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context);
  }

  void _handleForgotPassword() async {
    setState(() {
      _emailErrorText = FieldValidate.handleEmailValidate(_emailController.text);
    });
    if (_emailErrorText == null) {
      await AuthService.forgotPassword(
        email: _emailController.text,
        onSuccess: () async {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pushReplacementNamed(Routes.login);
          });

          SnackBarHelper.showSuccessSnackBar(
            context: context,
            content: _local.successResetPassword,
          );
        },
        onError: (message) => SnackBarHelper.showErrorSnackBar(
          context: context,
          content: message,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.fromLTRB(14, MediaQuery.of(context).padding.top, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 18),
            Text(
               _local.titleResetPassword,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 113, 240),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            Text(
              _local.subTitleResetPassword,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            Text(
              _local.email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              onChanged: (value) {
                setState(() {
                  _emailErrorText = FieldValidate.handleEmailValidate(value);
                });
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[400]),
                hintText: 'mail@example.com',
                errorText: _emailErrorText,
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color.fromARGB(255, 64, 169, 255),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Color.fromARGB(255, 217, 217, 217),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 14),
            TextButton(
              onPressed: _handleForgotPassword,
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                backgroundColor: Colors.blue[700],
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              child: Text(
                _local.resetPassword,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                _local.backToLogin,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
