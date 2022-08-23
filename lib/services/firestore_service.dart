import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keep_track_toolkit/models/tracker.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Stream<List<Tracker>> collectionStream({
    required String path,
    required Tracker Function(Map<String, dynamic> data, String documentID)
        builder,
  }) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();

    return snapshots
        .map((querySnapshot) => querySnapshot.docs)
        .map((listOfDocSnap) {
      return listOfDocSnap.map((docSnap) {
        return builder(
          docSnap.data(),
          docSnap.id,
        );
      }).toList();
    });
  }

  // Stream<List<T>> collectionStream<T>({
  //   required String path,
  //   required T Function(Map<String, dynamic> data, String documentID) builder,
  // }) {
  //   final reference = FirebaseFirestore.instance.collection(path);
  //   final snapshots = reference.snapshots();

  //   return snapshots
  //       .map((querySnapshot) => querySnapshot.docs)
  //       .map((listOfDocSnap) {
  //     return listOfDocSnap.map((docSnap) {
  //       return builder(
  //         docSnap.data(),
  //         docSnap.id,
  //       );
  //     }).toList();
  //   });
  // }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();

    return snapshots.map((snapshot) {
      return builder(snapshot.data()!, snapshot.id);
    });
  }
}
