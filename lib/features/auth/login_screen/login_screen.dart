import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String appLanguage = 'English';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/logo/lettutor_logo.svg',
            )),
        leadingWidth: 180,
        actions: <Widget>[
          Container(
              width: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              padding: const EdgeInsets.all(8),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  customButton: const Icon(
                    Icons.list,
                    size: 46,
                    color: Colors.red,
                  ),
                  value: appLanguage,
                  items: [
                    DropdownMenuItem<String>(
                      value: 'English',
                      child: SizedBox(
                          width: 200,
                          child: Row(children: [
                            SvgPicture.asset(
                              'assets/language/english.svg',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 10),
                            const Text('English')
                          ])),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Vietnamese',
                      child: Row(children: [
                        SvgPicture.asset('assets/language/vietnamese.svg',
                            width: 30, height: 30),
                        const SizedBox(width: 10),
                        const Text('Tiếng Việt')
                      ]),
                    ),
                  ],
                  onChanged: (String? language) {
                    setState(() {
                      appLanguage = language ?? "English";
                    });
                  },
                ),
              ))
        ],
      ),
    );
  }
}
