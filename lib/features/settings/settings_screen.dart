import 'package:flutter/material.dart';
import 'package:lettutor/features/settings/widgets/custom_card.dart';

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
          InkWell(
            onTap: () {},
            child: const CustomCard(
              icon: Icons.school_rounded,
              label: 'Account',
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {},
            child: const CustomCard(
              icon: Icons.school_rounded,
              label: 'Become a Tutor',
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {},
            child: const CustomCard(
              icon: Icons.logout,
              label: 'Log out',
            ),
          ),
        ],
      ),
    );
  }
}
