import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:keep_track_toolkit/services/auth.dart';
import 'package:provider/provider.dart';

class ProfilePageForm extends StatelessWidget {
  final User user;
  const ProfilePageForm({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User?>(
      builder: (context, snapshot) {
        return Center(
          child: Text(
            snapshot.data?.displayName ?? "None",
          ),
        );
      },
      stream: auth.userChanges(),
    );
  }
}
