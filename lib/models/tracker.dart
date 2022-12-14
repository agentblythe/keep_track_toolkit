import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keep_track_toolkit/models/tracker_interval_type.dart';
import 'package:keep_track_toolkit/models/tracker_type.dart';

class Tracker<T> {
  String name;
  List<Map<Timestamp, T>> values = [];
  TrackerIntervalType trackerIntervalType;
  TrackerType trackerType;

  Tracker({
    required this.name,
    required this.trackerIntervalType,
    required this.trackerType,
  });

  Tracker._({
    required this.name,
    required this.values,
    required this.trackerIntervalType,
    required this.trackerType,
  });

  factory Tracker.fromMap(Map<String, dynamic> data, String documentId) {
    final String name = data['name'];
    final int trackerIntervalType = data['trackerIntervalType'];
    final int trackerType = data['trackerType'];
    final List<Map<Timestamp, T>> values =
        data['values'].cast<Map<Timestamp, T>>();

    return Tracker._(
      name: name,
      values: values,
      trackerIntervalType: TrackerIntervalType.values[trackerIntervalType],
      trackerType: TrackerType.values[trackerType],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'values': values,
      'trackerIntervalType': trackerIntervalType,
      'trackerType': trackerType,
    };
  }
}
