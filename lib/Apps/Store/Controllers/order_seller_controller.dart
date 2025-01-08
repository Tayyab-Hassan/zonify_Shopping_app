import 'package:e_commerce_app/consts/consts.dart';

class OrderSellerController extends GetxController {
  var confirmed = false.obs;
  var confirmedOder = false.obs;
  var onDelivery = false.obs;
  var delivered = false.obs;
  var orders = [];
  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == currentUser!.uid) {
        orders.add(item);
      }
    }
  }

  // Change Order Status

  changeStatus({status, docId, title}) async {
    var store = firestore.collection(ordersCollection).doc(docId);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
