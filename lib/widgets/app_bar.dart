import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/models/language/language.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.appBarLeading, this.appBarTitle});

  final bool? appBarLeading;
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
      leading: widget.appBarLeading != null
          ? BackButton(
              color: Colors.blue[600],
            )
          : null,
      backgroundColor: Colors.white,
      title: Container(
        alignment: Alignment.centerLeft,
        child: widget.appBarTitle != null
            ? Text(
                widget.appBarTitle!,
                style: Theme.of(context).textTheme.displaySmall,
              )
            : IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.home);
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
    );
  }
}
