import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/models/language/language.dart';
import 'package:lettutor/providers/language/language_provider.dart';
import 'package:lettutor/widgets/bar/app_bar.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  void _switchLanguage(Language? value) async {
    Provider.of<LanguageProvider>(context, listen: false)
        .switchLanguage(value!);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Language appLanguage =
        Provider.of<LanguageProvider>(context).getLanguage();

    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: 'Language',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              titleAlignment: ListTileTitleAlignment.top,
              leading: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(68, 175, 175, 175),
                ),
                child: Icon(
                  Icons.language,
                  size: 28,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              title: const Text(
                'Language Settings',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: const Text(
                'Choose a language to display for your LetTutor app experience. You can change the language back at any time.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 14),
              child: Column(
                children: languageList
                    .map<Widget>(
                      (language) => ListTile(
                        trailing: Radio<Language>(
                          value: language,
                          groupValue: appLanguage,
                          onChanged: (Language? value) {
                            _switchLanguage(value);
                          },
                          activeColor: Colors.blue,
                        ),
                        title: Text(
                          language.name!,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
