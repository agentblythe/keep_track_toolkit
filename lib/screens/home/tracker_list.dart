import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/models/tracker.dart';
import 'package:keep_track_toolkit/services/database.dart';
import 'package:keep_track_toolkit/utils/list_items_builder.dart';
import 'package:provider/provider.dart';

class TrackerList extends StatelessWidget {
  const TrackerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);

    return StreamBuilder<List<Tracker>>(
      stream: database.allTrackersStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Tracker>(
          snapshot: snapshot,
          itemBuilder: (context, tracker) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(tracker.name),
                subtitle: Text(tracker.trackerType.description),
                trailing: Text(tracker.values.length.toString()),
              ),
            );
          },
        );
      },
    );
  }
}
