import 'package:keep_track_toolkit/models/tracker_interval_type.dart';
import 'package:keep_track_toolkit/models/tracker_type.dart';

class Tracker<T> {
  String name;
  // List<Result<T>> values = [];
  // TrackerIntervalType trackerIntervalType;
  // TrackerType trackerType;

  Tracker({
    required this.name,
    // required this.trackerIntervalType,
    // required this.trackerType,
  });

  // Tracker._({
  //   required this.values,
  //   required this.trackerIntervalType,
  //   required this.trackerType,
  // });

  // void addValue(Result<T> value) {
  //   values.add(value);
  // }

  // void removeValueAtIndex(int index) {
  //   values.removeAt(index);
  // }

  factory Tracker.fromMap(Map<String, dynamic> data, String documentId) {
    final String name = data['name'];
    // final List<Result<T>> values = data['values'];
    // final int trackerIntervalType = data['trackerIntervalType'];
    // final int trackerType = data['trackerType'];

    return Tracker(
      name: name,
    );

    // return Tracker._(
    //   values: values,
    //   trackerIntervalType: TrackerIntervalType.values[trackerIntervalType],
    //   trackerType: TrackerType.values[trackerType],
    // );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      // 'values': values,
      // 'trackerIntervalType': trackerIntervalType,
      // 'trackerType': trackerType,
    };
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
