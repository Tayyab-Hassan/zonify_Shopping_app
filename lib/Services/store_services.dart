import 'package:e_commerce_app/consts/consts.dart';

class StoreServices {
  static getProfile(uid) {
    return firestore
        .collection(vendorCollection)
        .where('ownerId', isEqualTo: uid)
        .snapshots();
  }

  static getAllChats() {
    return firestore
        .collection(chatsCollection)
        .where('sellerID', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getOrders(uid) {
    return firestore
        .collection(ordersCollection)
        .where('vendors', arrayContains: uid)
        .snapshots();
  }

  static getProducts(uId) {
    return firestore
        .collection(productsCollection)
        .where("vendor_id", isEqualTo: uId)
        .snapshots();
  }

  static getPopularProducts(uid) {
    return firestore
        .collection(productsCollection)
        .where("vendor_id", isEqualTo: uid)
        .orderBy("p_wishlist".length);
  }
}
