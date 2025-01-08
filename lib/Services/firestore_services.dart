import 'package:e_commerce_app/consts/consts.dart';

class FirestoreServices {
  // Get User Data From FireBase Using their UserId
  static getUser(uid) {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  // Get products According to Categories
  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getsubCategoryProducts(subCategory) {
    return firestore
        .collection(productsCollection)
        .where('p_subcategory', isEqualTo: subCategory)
        .snapshots();
  }

  // Get Cart Data
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  // Get all Chats Messages From FireStore
  static getAllMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  // Get All Orders
  static getAllOrder() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  // Get All Wishlist Products
  static getAllWishList() {
    return firestore
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  // Get All User Chats
  static getAllChats() {
    return firestore
        .collection(chatsCollection)
        .where('customerID', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  // Get All Cart ,WishList and Order Length

  static getAllDoucmentsLength() async {
    var res = Future.wait([
      firestore
          .collection(cartCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productsCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ordersCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  // Get All Porducts
  static getAllProducts() {
    return firestore.collection(productsCollection).snapshots();
  }

  // Get Featured Products
  static getFeaturedProducts() {
    return firestore
        .collection(productsCollection)
        .where('is_featured', isEqualTo: true)
        .snapshots();
  }

  // Get Search Products
  static searchProdusts(title) {
    return firestore
        .collection(productsCollection)
        .where('p_name', isLessThanOrEqualTo: title)
        .get();
  }
}
