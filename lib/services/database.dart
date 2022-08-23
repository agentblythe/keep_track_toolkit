import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keep_track_toolkit/models/tracker.dart';
import 'package:keep_track_toolkit/services/api_path.dart';
import 'package:keep_track_toolkit/services/firestore_service.dart';

abstract class Database {
  // Read
  Stream<List<Tracker>> allTrackersStream();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Stream<List<Tracker>> allTrackersStream() {
    return _service.collectionStream(
        path: APIPath.trackers(uid),
        builder: (data, documentID) {
          return Tracker.fromMap(data, documentID);
        });
  }
}
