import 'package:flutter/material.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/features/settings/widgets/custom_list_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
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
                  child: Image.asset(
                    'assets/avatar/user/user_avatar.jpeg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person_rounded, size: 62),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Keegan',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomListTile(
            leadingIcon: Icons.person_rounded,
            titleText: 'Account',
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
              'General',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          CustomListTile(
            leadingIcon: Icons.language_rounded,
            titleText: 'Languages',
            onTap: () {},
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
            onTap: () {},
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
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.login,
                (route) => false,
              );
            },
            isTrailing: false,
          ),
        ],
      ),
    );
  }
}
