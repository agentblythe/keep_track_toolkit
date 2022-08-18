import 'package:keep_track_toolkit/models/tracker.dart';

abstract class Database {
  // Read
  Stream<List<Tracker>> allTrackersStream();
  Stream<Tracker> singleTrackerStream({required String trackerId});
}

class FireStoreDatabase implements Database {
  //final _service = FireStoreService.instance;
  @override
  Stream<List<Tracker>> allTrackersStream() {
    throw UnimplementedError();
  }

  @override
  Stream<Tracker> singleTrackerStream({required String trackerId}) {
    throw UnimplementedError();
  }
}
