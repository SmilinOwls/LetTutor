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
  void _toggleTheme(bool? value) async {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value!);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> themeOptions = <String, bool>{
      'On': true,
      'Off': false,
    };

    bool isDark = Provider.of<ThemeProvider>(context, listen: false).isDark();
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
                children: themeOptions.entries
                    .map<Widget>(
                      (MapEntry theme) => ListTile(
                        trailing: Radio<bool>(
                          value: theme.value,
                          groupValue: isDark,
                          onChanged: (bool? value) {
                            _toggleTheme(value);
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                        title: Text(
                          theme.key.toString(),
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
