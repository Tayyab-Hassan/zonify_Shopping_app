import 'package:e_commerce_app/Apps/UserSide/Controllers/home_controller.dart';
import 'package:e_commerce_app/consts/consts.dart';

class CartController extends GetxController {
  var totalP = 0.obs;
  var paymentIndex = 0.obs;
  late dynamic productSnapshot;
  var products = [];
  var isPlacingOrder = false.obs;
  // controller for shipping Details
  var adressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalController = TextEditingController();
  var phoneController = TextEditingController();

// For Cart Total Calculations
  calulateTotal(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tPrice'].toString());
    }
  }

  // Change PaymentMethod
  changeMethodIndex(index) {
    paymentIndex.value = index;
  }

  // Confirmed the Order
  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    isPlacingOrder(true);
    await getProductDetails();

    await firestore.collection(ordersCollection).doc().set({
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': adressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      'order_by_postalcode': postalController.text,
      'shipping_method': 'Home Delivery',
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_code': '23434534',
      'order_date': DateTime.now(),
      'order_confirmed': false,
      'order_on_delivery': false,
      'order_delivered': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products)
    });
    isPlacingOrder(false);
  }

  // For Get the Product Details Which is Placed in Order
  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'quantity': productSnapshot[i]['quantity'],
        'title': productSnapshot[i]['title'],
        'tPrice': productSnapshot[i]['tPrice'],
        'vendor_id': productSnapshot[i]['vendor_id'],
      });
    }
  }

// When Oders Is Placed Then Clear the Cart
  clearCart() async {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
