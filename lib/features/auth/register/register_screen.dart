import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/services/auth_service.dart';
import 'package:lettutor/utils/field_validate.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/widgets/bar/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _passwordVisible = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  String? _emailErrorText;
  String? _passwordErrorText;
  String? _rePasswordErrorText;

   late AppLocalizations _local;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context);
  }
  
  void _handleRegister() async {
    setState(() {
      _emailErrorText = FieldValidate.handleEmailValidate(_emailController.text);
      _passwordErrorText = FieldValidate.handlePasswordValidate(_passwordController.text);
      _rePasswordErrorText =
         FieldValidate.handleRePasswordValidate(_rePasswordController.text, _passwordController.text);
    });
    if (_emailErrorText == null &&
        _passwordErrorText == null &&
        _rePasswordErrorText == null) {
      await AuthService.registerWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
        onSuccess: () async {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pushReplacementNamed(Routes.login);
          });

          SnackBarHelper.showSuccessSnackBar(
            context: context,
            content: _local.successSignUp,
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
            Image.asset('assets/background/login_background.png'),
            const SizedBox(height: 18),
            Text(
              _local.titleSignUp,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 113, 240),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            Text(
              _local.subTitleSignUp,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 42, 52, 83),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            Text(
              _local.email.toUpperCase(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
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
                    width: 0.5,
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
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
            const SizedBox(height: 28),
            Text(
              _local.password.toUpperCase(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: !_passwordVisible,
              autocorrect: false,
              onChanged: (value) {
                setState(() {
                  _passwordErrorText = FieldValidate.handlePasswordValidate(value);
                });
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                errorText: _passwordErrorText,
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
                    width: 1,
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
            Text(
              _local.rePassword.toUpperCase(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _rePasswordController,
              keyboardType: TextInputType.text,
              obscureText: !_passwordVisible,
              autocorrect: false,
              onChanged: (value) {
                setState(() {
                  _rePasswordErrorText =FieldValidate.handleRePasswordValidate(value, _passwordController.text);
                });
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                errorText: _rePasswordErrorText,
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
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
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 18),
            TextButton(
              onPressed: () {
                _handleRegister();
              },
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
                _local.signUp.toUpperCase(),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
             Text(
              _local.alreadyAMember,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/logo/facebook_logo.svg',
                        width: 36,
                        height: 36,
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/logo/google_logo.svg',
                        width: 36,
                        height: 36,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _local.alreadyAMember,
                  style: const TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.login,
                    );
                  },
                  child: Text(
                    _local.signUp.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
