import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:lettutor/models/language/language.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _appLanguage = 'English';
  bool _passwordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.home);
            },
            icon: SvgPicture.asset(
              'assets/logo/lettutor_logo.svg',
            )),
        leadingWidth: 180,
        elevation: 18,
        actions: <Widget>[
          Container(
              width: 180,
              padding: const EdgeInsets.all(8),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  customButton: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[400],
                      ),
                      child: SvgPicture.asset(
                        'assets/language/${_appLanguage.toLowerCase()}.svg',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  value: _appLanguage,
                  items: [
                    ...languageList.map<DropdownMenuItem<String>>(
                      (Language lang) => DropdownMenuItem<String>(
                        value: lang.name,
                        child: SizedBox(
                            child: Row(children: [
                          SvgPicture.asset(
                            lang.flag!,
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            lang.name!,
                            style: TextStyle(
                                fontWeight: _appLanguage == lang.name
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          )
                        ])),
                      ),
                    )
                  ],
                  onChanged: (String? language) {
                    setState(() {
                      _appLanguage = language ?? "English";
                    });
                  },
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/background/login_background.png'),
            const SizedBox(height: 18),
            const Text(
              'Say hello to your English tutors',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 113, 240),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            const Text(
              'Become fluent faster through one on one video chat lessons tailored to your goals.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 42, 52, 83),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            const Text(
              'EMAIL',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[400]),
                hintText: 'mail@example.com',
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: Color.fromARGB(255, 64, 169, 255)),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Color.fromARGB(255, 217, 217, 217)),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'PASSWORD',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: !_passwordVisible,
              autocorrect: false,
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
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: Color.fromARGB(255, 64, 169, 255)),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ),
            const SizedBox(height: 28),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.forgotPassword);
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 16, color: Colors.blue),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 14),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                backgroundColor: Colors.blue[700],
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              child: const Text(
                'LOG IN',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              textAlign: TextAlign.center,
              'Or continue with',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/logo/facebook_logo.svg',
                        width: 46,
                        height: 46,
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
                        width: 46,
                        height: 46,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Not a member yet?',
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.register);
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
