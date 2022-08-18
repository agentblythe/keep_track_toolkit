enum TrackerIntervalType {
  daily,
  weekly,
  monthly,
}

extension TrackerIntervalTypeExtension on TrackerIntervalType {
  String get name {
    switch (this) {
      case TrackerIntervalType.daily:
        return "Daily";
      case TrackerIntervalType.weekly:
        return "Weekly";
      case TrackerIntervalType.monthly:
        return "Monthly";
    }
  }
}
