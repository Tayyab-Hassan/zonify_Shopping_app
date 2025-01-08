import 'package:e_commerce_app/Apps/UserSide/Controllers/home_controller.dart';
import 'package:e_commerce_app/consts/consts.dart';

class ChatsController extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var isLoading = false.obs;
  var receverName = Get.arguments[0];
  var sellerId = Get.arguments[1];
  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;
  var msgConttroller = TextEditingController();
  dynamic chatDocId;
  var chats = firestore.collection(chatsCollection);

  getChatId() async {
    isLoading(true);
    await chats
        .where('users', isEqualTo: {sellerId: null, currentId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              'created_on': null,
              'last_msg': '',
              'users': {sellerId: null, currentId: null},
              // Recever Id
              'sellerID': '',

              'customerID': '',
              'seller_name': receverName,
              'customer_name': senderName
            }).then((value) {
              {
                chatDocId = value.id;
              }
            });
          }
        });
    isLoading(false);
  }

  // Sender Messages
  sendMessage(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'sellerID': sellerId,
        'customerID': currentId
      });

      // Chats Collection To Store The Messages
      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId
      });
    }
  }
}
