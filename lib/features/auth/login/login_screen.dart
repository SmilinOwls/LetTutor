import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/models/auth/tokens.dart';
import 'package:lettutor/models/user/user.dart';
import 'package:lettutor/providers/auth/auth_provider.dart';
import 'package:lettutor/services/auth_service.dart';
import 'package:lettutor/utils/field_validate.dart';
import 'package:lettutor/utils/localization.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/widgets/bar/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailErrorText;
  String? _passwordErrorText;

  late AppLocalizations _local;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context);
  }


  void _onSuccessLogin(User user, Tokens tokens) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('refresh_token', tokens.refresh!.token!);
    await prefs.setString('access_token', tokens.access!.token!);

    if (context.mounted) {
      Provider.of<AuthProvider>(context, listen: false).setUser(user);

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.main, (route) => false);
      });

      SnackBarHelper.showSuccessSnackBar(
        context: context,
        content: AppLocalizations.of(context).successLogin,
      );
    }
  }

  void _handleLogin() async {
    setState(() {
      _emailErrorText = FieldValidate.handleEmailValidate(_emailController.text);
      _passwordErrorText = FieldValidate.handlePasswordValidate(_passwordController.text);
    });
    if (_emailErrorText == null && _passwordErrorText == null) {
      await AuthService.loginWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
        onSuccess: _onSuccessLogin,
        onError: (message) => SnackBarHelper.showErrorSnackBar(
          context: context,
          content: message,
        ),
      );
    }
  }

  void _handleGoogleLogin() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    ).signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final String? accessToken = googleAuth?.accessToken;

    if (accessToken != null) {
      await AuthService.loginByGoogle(
        accessToken: accessToken,
        onSuccess: _onSuccessLogin,
        onError: (message) => SnackBarHelper.showErrorSnackBar(
          context: context,
          content: message,
        ),
      );
    }
  }

  void _handleFacebookLogin() async {
    final result = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile'],
    );

    if (result.status == LoginStatus.success) {
      final String accessToken = result.accessToken!.token;
      await AuthService.loginByFacebook(
        accessToken: accessToken,
        onSuccess: _onSuccessLogin,
        onError: (message) => SnackBarHelper.showErrorSnackBar(
          context: context,
          content: message,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Localization.initialize(context);
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
              _local.titleLogin,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 113, 240),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            Text(
              _local.subtitleLogin,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            Text(
              _local.email.toUpperCase(),
              style: const TextStyle(fontSize: 16, color: Colors.grey),
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
                  borderSide: BorderSide(width: 0.5, color: Colors.grey),
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
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.grey,
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
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 28),
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.forgotPassword,
                );
              },
              child: Text(
                _local.forgotPassword,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 14),
            TextButton(
              onPressed: () {
                _handleLogin();
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
                _local.login.toUpperCase(),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _local.loginWithThirdParty,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                      onPressed: _handleFacebookLogin,
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
                      onPressed: _handleGoogleLogin,
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
                  _local.notAMemberYet,
                  style: const TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.register);
                  },
                  child: Text(
                    _local.signUp,
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
