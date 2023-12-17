import 'package:flutter/material.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/features/account/settings/display_screen.dart';
import 'package:lettutor/features/account/settings/language_screen.dart';
import 'package:lettutor/features/account/widgets/custom_list_tile.dart';
import 'package:lettutor/providers/auth/auth_provider.dart';
import 'package:lettutor/providers/language/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().getUser();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Container(
                  width: 120,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    user?.avatar ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person_rounded, size: 62),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user?.name ?? '',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomListTile(
            leadingIcon: Icons.person_rounded,
            titleText: 'About me',
            onTap: () {
              Navigator.of(context).pushNamed(Routes.userProfile);
            },
            isTrailing: true,
          ),
          CustomListTile(
            leadingIcon: Icons.school_rounded,
            titleText: 'Become a tutor',
            onTap: () {
              Navigator.of(context).pushNamed(Routes.tutorBecome);
            },
            isTrailing: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            child: Text(
              'Settings',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          CustomListTile(
            leadingIcon: Icons.language_rounded,
            titleText: 'Languages',
            subTitleText:
                Provider.of<LanguageProvider>(context).getLanguage().name,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LanguageScreen(),
              ));
            },
            isTrailing: true,
          ),
          CustomListTile(
            leadingIcon: Icons.help_rounded,
            titleText: 'Help & Support',
            onTap: () {},
            isTrailing: true,
          ),
          CustomListTile(
            leadingIcon: Icons.dark_mode_rounded,
            titleText: 'Display',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const DisplayScreen(),
              ));
            },
            isTrailing: true,
          ),
          CustomListTile(
            leadingIcon: Icons.feedback_rounded,
            titleText: 'Give a feedback',
            onTap: () {},
            isTrailing: false,
          ),
          CustomListTile(
            leadingIcon: Icons.logout_rounded,
            titleText: 'Log out',
            onTap: () async {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.login,
                (route) => false,
              );

              final prefs = await SharedPreferences.getInstance();
              prefs.clear();
            },
            isTrailing: false,
          ),
        ],
      ),
    );
  }
}
