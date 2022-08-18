import 'package:keep_track_toolkit/models/tracker_interval_type.dart';
import 'package:keep_track_toolkit/models/tracker_type.dart';

class Tracker<T> {
  List<Result<T>> values = [];
  TrackerIntervalType trackerIntervalType;
  TrackerType trackerType;

  Tracker({
    required this.trackerIntervalType,
    required this.trackerType,
  });

  void addValue(Result<T> value) {
    values.add(value);
  }

  void removeValueAtIndex(int index) {
    values.removeAt(index);
  }
}

class Result<T> {
  DateTime dateTime;
  T result;

  Result({
    required this.dateTime,
    required this.result,
  });
}
