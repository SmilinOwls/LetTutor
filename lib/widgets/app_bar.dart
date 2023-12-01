import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/models/language/language.dart';
import 'package:lettutor/providers/language/language_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.appBarTitle});

  final String? appBarTitle;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    final selectedLanguage = languageProvider.getLanguage();

    return AppBar(
      title: Container(
        alignment: Alignment.centerLeft,
        child: widget.appBarTitle != null
            ? Text(
                widget.appBarTitle!.toUpperCase(),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 24,
                ),
              )
            : IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.main);
                },
                icon: SvgPicture.asset(
                  'assets/logo/lettutor_logo.svg',
                  height: 42,
                ),
              ),
      ),
      elevation: 9,
      actions: <Widget>[
        Container(
          width: 200,
          padding: const EdgeInsets.all(6),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<Language>(
              customButton: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[400],
                  ),
                  child: SvgPicture.asset(
                    'assets/language/${selectedLanguage.name!.toLowerCase()}.svg',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              value: selectedLanguage,
              items: [
                ...languageList.map<DropdownMenuItem<Language>>(
                  (Language lang) => DropdownMenuItem<Language>(
                    value: lang,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: SvgPicture.asset(
                        lang.flag!,
                        width: 30,
                        height: 30,
                      ),
                      title: Text(
                        lang.name!,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: selectedLanguage.name! == lang.name
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      trailing: selectedLanguage.name! == lang.name
                          ? Icon(
                              Icons.check,
                              color: Theme.of(context).primaryColor,
                            )
                          : null,
                    ),
                  ),
                )
              ],
              onChanged: (Language? language) {
                languageProvider.switchLanguage(language!);
              },
            ),
          ),
        ),
      ],
    );
  }
}
