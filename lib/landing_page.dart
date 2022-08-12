import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/screens/home/home_page.dart';
import 'package:keep_track_toolkit/screens/sign-in/sign_in_page.dart';
import 'package:keep_track_toolkit/services/auth.dart';
import 'package:keep_track_toolkit/theme/theme_manager.dart';
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
          return ChangeNotifierProvider<ThemeManager>(
            create: (context) => ThemeManager(),
            child: const HomePage(),
          );
          // return Provider<Database>(
          //   create: (_) => FirestoreDatabase(),
          //   child: HomePage(),
          // );
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
