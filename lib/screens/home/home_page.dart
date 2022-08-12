import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/theme/keep_track_toolkit_theme.dart';
import 'package:keep_track_toolkit/theme/theme_manager.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        ThemeData theme;
        if (themeManager.darkMode) {
          theme = KeepTrackToolkitTheme.dark();
        } else {
          theme = KeepTrackToolkitTheme.light();
        }
        return MaterialApp(
          theme: theme,
          home: Scaffold(
            appBar: AppBar(
                title: const Text('Keep Track Toolkit'),
                actions: <Widget>[
                  Switch(
                    value: themeManager.darkMode,
                    onChanged: (darkMode) {
                      themeManager.darkMode = darkMode;
                    },
                  )
                ]),
            body: const Center(
              child: Text("Home Page"),
            ),
          ),
        );
      },
    );
  }
}
