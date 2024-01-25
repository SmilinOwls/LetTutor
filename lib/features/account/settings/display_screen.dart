import 'package:flutter/material.dart';
import 'package:lettutor/providers/theme/theme_provider.dart';
import 'package:lettutor/widgets/bar/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  late AppLocalizations _local;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context);
  }

  void _toggleTheme(bool? value) async {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value!);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> themeOptions = <String, bool>{
      _local.on: true,
      _local.off: false,
    };

    bool isDark = Provider.of<ThemeProvider>(context, listen: false).isDark();
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: _local.display),
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
              title:  Text(
                _local.darkMode,
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                _local.displayScreenDescription,
                style: const TextStyle(fontSize: 14),
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
