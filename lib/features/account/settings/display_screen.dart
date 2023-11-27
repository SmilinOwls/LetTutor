import 'package:flutter/material.dart';
import 'package:lettutor/providers/theme/theme_provider.dart';
import 'package:lettutor/widgets/app_bar.dart';
import 'package:provider/provider.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: 'Display',
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
                  Icons.dark_mode,
                  size: 28,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              title: const Text(
                'Dark Mode',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: const Text(
                'Adjust the appearance of LetTutor to reduce glare and give your eyes a break.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 14),
              child: Column(
                children: [
                  ListTile(
                    trailing: Radio<bool>(
                      value: true,
                      groupValue: themeProvider.isDarkMode(),
                      onChanged: (bool? value) {
                        themeProvider.toggleTheme(value!);
                      },
                      activeColor: Colors.blue,
                    ),
                    title: const Text(
                      'On',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ListTile(
                    trailing: Radio<bool>(
                      value: false,
                      groupValue: themeProvider.isDarkMode(),
                      onChanged: (bool? value) {
                        themeProvider.toggleTheme(value!);
                      },
                      activeColor: Colors.blue,
                    ),
                    title: const Text(
                      'Off',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
