import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/navigation/app_routes.dart';
import 'package:keep_track_toolkit/screens/home/home_page.dart';
import 'package:keep_track_toolkit/screens/profile/profile_page.dart';
import 'package:keep_track_toolkit/screens/sign-in/sign_in_page.dart';
import 'package:keep_track_toolkit/services/auth.dart';
import 'package:keep_track_toolkit/profile/profile_manager.dart';
import 'package:keep_track_toolkit/theme/keep_track_toolkit_theme.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          }
          return ChangeNotifierProvider<ProfileManager>(
            create: (context) => ProfileManager(
              appUser: user,
            ),
            child: Consumer<ProfileManager>(
              builder: (context, profileManager, child) {
                ThemeData theme;
                if (profileManager.darkMode) {
                  theme = KeepTrackToolkitTheme.dark();
                } else {
                  theme = KeepTrackToolkitTheme.light();
                }
                return MaterialApp(
                  theme: theme,
                  onGenerateRoute: (settings) {
                    print(settings.name);
                    late Widget page;
                    if (settings.name == AppRoutes.routeHome) {
                      page = const HomePage();
                    } else if (settings.name == AppRoutes.routeProfile) {
                      page = ProfilePage(appUser: profileManager.appUser);
                    } else {
                      throw Exception('Unknown route: ${settings.name}');
                    }
                    return MaterialPageRoute<dynamic>(
                      builder: (context) {
                        return page;
                      },
                      settings: settings,
                    );
                  },
                );
              },
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
