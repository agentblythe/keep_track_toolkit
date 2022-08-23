import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/models/tracker.dart';
import 'package:keep_track_toolkit/services/api_path.dart';
import 'package:keep_track_toolkit/services/auth.dart';
import 'package:keep_track_toolkit/services/database.dart';
import 'package:keep_track_toolkit/utils/list_items_builder.dart';
import 'package:provider/provider.dart';

class TrackerList extends StatelessWidget {
  const TrackerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    final auth = Provider.of<AuthBase>(context, listen: false);

    // return StreamBuilder<QuerySnapshot>(
    //   stream: database.allTrackersStream(),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return const Text('Something went wrong');
    //     }

    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Text("Loading");
    //     }

    //     return ListView(
    //       children: snapshot.data!.docs
    //           .map((DocumentSnapshot document) {
    //             Map<String, dynamic> data =
    //                 document.data()! as Map<String, dynamic>;

    //             var values =
    //                 data['values'] as List<dynamic>; // as Map<String, dynamic>;

    //             return ListTile(
    //               title: Text(data['name']),
    //             );
    //           })
    //           .toList()
    //           .cast(),
    //     );
    //   },
    // );

    return StreamBuilder<List<Tracker>>(
      stream: database.testAllTrackersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return ListItemsBuilder<Tracker>(
          snapshot: snapshot,
          itemBuilder: (context, tracker) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${tracker.name} / ${tracker.trackerIntervalType.name} / ${tracker.trackerType.name} / ${tracker.values.length}",
              ),
            );
          },
        );
      },
    );
  }
}
