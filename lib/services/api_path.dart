class APIPath {
  static String tracker(String uid, String trackerId) =>
      'users/$uid/trackers/$trackerId';
  static String trackers(String uid) => 'users/$uid/trackers';
}
