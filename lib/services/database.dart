import 'package:keep_track_toolkit/models/tracker.dart';
import 'package:keep_track_toolkit/services/api_path.dart';
import 'package:keep_track_toolkit/services/firestore_service.dart';

abstract class Database {
  // Read
  Stream<List<Tracker>> allTrackersStream();
  Stream<Tracker> singleTrackerStream({required String trackerId});
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Stream<List<Tracker>> allTrackersStream() => _service.collectionStream(
        path: APIPath.trackers(uid),
        builder: (data, documentID) => Tracker.fromMap(data, documentID),
      );

  @override
  Stream<Tracker> singleTrackerStream({required String trackerId}) =>
      _service.documentStream(
        path: APIPath.tracker(uid, trackerId),
        builder: (data, documentID) => Tracker.fromMap(data, documentID),
      );
}
