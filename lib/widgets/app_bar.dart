import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/models/language/language.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.appBarTitle});

  final String? appBarTitle;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String _appLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        alignment: Alignment.centerLeft,
        child: widget.appBarTitle != null
            ? Text(
                widget.appBarTitle!.toUpperCase(),
                style: Theme.of(context).textTheme.displayMedium,
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
      elevation: 18,
      actions: <Widget>[
        Container(
          width: 200,
          padding: const EdgeInsets.all(6),
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
                          fontWeight: _appLanguage == lang.name
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      trailing: _appLanguage == lang.name
                          ? Icon(
                              Icons.check,
                              color: Theme.of(context).primaryColor,
                            )
                          : null,
                    ),
                  ),
                )
              ],
              onChanged: (String? language) {
                setState(() {
                  _appLanguage = language ?? "English";
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
