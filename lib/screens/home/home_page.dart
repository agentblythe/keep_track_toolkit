import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keep_track_toolkit/common-widgets/show_alert_dialog.dart';
import 'package:keep_track_toolkit/profile/navigation/app_routes.dart';
import 'package:keep_track_toolkit/profile/profile_manager.dart';
import 'package:keep_track_toolkit/screens/home/tracker_list.dart';
import 'package:keep_track_toolkit/services/auth.dart';
import 'package:keep_track_toolkit/services/database.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var profileManager = Provider.of<ProfileManager>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keep Track Toolkit'),
        elevation: 2.0,
        leading: _buildUserProfileButton(
          profileManager.appUser,
          context,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
            ),
            onPressed: () => _confirmSignOut(context),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: const Icon(FontAwesomeIcons.plus),
      ),
      body: Provider<Database>(
        create: (_) => FirestoreDatabase(
          uid: Provider.of<AuthBase>(context, listen: false).currentUser!.uid,
        ),
        child: const TrackerList(),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      debugPrint("Sign-out failed with exception: ${e.toString()}");
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: "Sign out confirmation",
      content: "Are you sure you want to sign out?",
      defaultAction: AlertAction(text: "Sign out", destructive: true),
      cancelAction: AlertAction(text: "Cancel"),
    );

    if (didRequestSignOut == true) {
      if (!mounted) return;
      _signOut(context);
    }
  }

  Widget _buildUserProfileButton(User appUser, BuildContext context) {
    return IconButton(
      icon: appUser.photoURL == null
          ? const Icon(FontAwesomeIcons.user)
          : Image.network(appUser.photoURL!),
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.routeProfile);
      },
    );
  }
}
