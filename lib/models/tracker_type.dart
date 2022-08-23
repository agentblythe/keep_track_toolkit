enum TrackerType {
  numeric,
  timebased,
  boolean;

  String get description {
    switch (this) {
      case TrackerType.numeric:
        return "Numeric";
      case TrackerType.timebased:
        return "Time Based";
      default:
        return "Yes/No";
    }
  }
}
