import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStorageApi {
  static FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  static addCollection(
      {required String collection, required Map<String, dynamic> map}) {
    _fireStore.collection(collection).add(map);
  }

  static Future<bool> doesUserWithEmailExist(
      String email, String collection) async {
    // Access Firestore instance

    // Query the collection where user data is stored
    // Replace 'users' with the name of your collection
    final querySnapshot = await _fireStore
        .collection(collection)
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    // Check if the query returned any documents
    return querySnapshot.docs.isNotEmpty;
  }

  static Future<Map<String, dynamic>> userDoc(
      {required String email,
      required String password,
      required String collection}) async {
    final querySnapshot = await _fireStore
        .collection(collection)
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty ? querySnapshot.docs.first.data() : {};
  }
}
