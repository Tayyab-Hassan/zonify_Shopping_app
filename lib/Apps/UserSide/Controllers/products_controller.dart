import 'package:e_commerce_app/Models/category_model.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:flutter/services.dart';

class ProductsController extends GetxController {
  var subcat = [];
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var isFev = false.obs;

  // Get SubCategories for a specific category
  getSubCategories(title) async {
    subcat.clear();
    // Load JSON File
    var data = await rootBundle.loadString("lib/Services/category_model.json");
    // Decode the data and store it
    var decoded = categoryModelFromJson(data);
    // Filter data according to the category title
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    // Add the filtered subcategories to the list
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  // Change the selected color
  changeColor(index) {
    colorIndex.value = index;
  }

  // Increase quantity
  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  // Decrease quantity
  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  // Calculate total price based on quantity
  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  // Add product to cart
  addToCart(
      {title,
      img,
      color,
      sellername,
      quantity,
      tPrice,
      vendorID,
      context}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'quantity': quantity,
      'tPrice': tPrice,
      'color': color,
      'vendor_id': vendorID,
      'added_by': currentUser!.uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
    VxToast.show(context, msg: "Added to Cart");
  }

  // Reset item details
  resetValue() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  // Add product to wishlist
  addToWishList(docId, context) async {
    try {
      await firestore.collection(productsCollection).doc(docId).set({
        'p_wishlist': FieldValue.arrayUnion([currentUser!.uid]), // Add UID
      }, SetOptions(merge: true)); // Merge ensures the field is updated
      isFev(true); // Update local state
      VxToast.show(context, msg: "Added To Wishlist");
    } catch (e) {
      VxToast.show(context, msg: "Error: ${e.toString()}");
    }
  }

  // Remove product from wishlist
  removeFromWishList(docId, context) async {
    try {
      await firestore.collection(productsCollection).doc(docId).set({
        'p_wishlist': FieldValue.arrayRemove([currentUser!.uid]), // Remove UID
      }, SetOptions(merge: true)); // Merge ensures the field is updated
      isFev(false); // Update local state
      VxToast.show(context, msg: "Removed From Wishlist");
    } catch (e) {
      VxToast.show(context, msg: "Error: ${e.toString()}");
    }
  }

  // Check if product is in wishlist
  checkIsFev(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFev(true);
    } else {
      isFev(false);
    }
  }
}
