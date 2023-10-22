import 'package:flutter/material.dart';
import 'package:lettutor/widgets/app_bar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final _emailController = TextEditingController();

  String? _emailErrorText;

  String? _handleEmailValidate(value) {
    final emailRegExp = RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    if (value.isEmpty) {
      return 'Please input your email!';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'The input is not valid E-mail!';
    } else {
      return null;
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
          children: [
            const SizedBox(height: 18),
            const Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 113, 240),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            const Text(
              'Please enter your email address to search for your account.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 42, 52, 83),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            const Text(
              'Email',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              onChanged: (value) {
                setState(() {
                  _emailErrorText = _handleEmailValidate(value);
                });
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[400]),
                hintText: 'mail@example.com',
                errorText: _emailErrorText,
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
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
                'Send reset link',
                style: TextStyle(
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
              child: const Text(
                'Back to login',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
