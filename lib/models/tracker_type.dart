enum TrackerType {
  numeric,
  timebased,
  boolean,
}

extension TrackerTypeExtension on TrackerType {
  String get name {
    switch (this) {
      case TrackerType.numeric:
        return "Numeric";
      case TrackerType.timebased:
        return "Time Based";
      case TrackerType.boolean:
        return "Boolean";
    }
  }
}
