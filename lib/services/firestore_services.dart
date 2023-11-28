import 'package:emart/consts/consts.dart';

// get user data
class FirestoreSerives {
  static getUser(uid) {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getProduct({category}) {
    return firestore
        .collection(productCollection)
        .where('category', isEqualTo: category)
        .snapshots();
  }

  static getCart({uid}) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  // delete cart

  static deleteCart({docid}) {
    return firestore.collection(cartCollection).doc(docid).delete();
  }

  // get chat message
  static getChatMessages({doctId}) {
    return firestore
        .collection(chatCollection)
        .doc(doctId)
        .collection(messageCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrders() {
    return firestore
        .collection(orderCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishList() {
    return firestore
        .collection(productCollection)
        .where('wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessage() {
    return firestore
        .collection(chatCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productCollection)
          .where('wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(orderCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static getAllProducts() {
    return firestore.collection(productCollection).snapshots();
  }
}
