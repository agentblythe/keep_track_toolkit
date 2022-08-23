import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keep_track_toolkit/models/tracker.dart';
import 'package:keep_track_toolkit/services/api_path.dart';
import 'package:keep_track_toolkit/services/firestore_service.dart';

abstract class Database {
  // Read
  Stream<List<Tracker>> testAllTrackersStream();
  // Stream<Tracker> singleTrackerStream({required String trackerId});
  Stream<QuerySnapshot> allTrackersStream();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Stream<QuerySnapshot> allTrackersStream() {
    return _service.getCollection(path: APIPath.trackers(uid)).snapshots();
  }

  @override
  Stream<List<Tracker>> testAllTrackersStream() {
    return _service.collectionStream(
        path: APIPath.trackers(uid),
        builder: (data, documentID) {
          return Tracker.fromMap(data, documentID);
        });
  }
}
