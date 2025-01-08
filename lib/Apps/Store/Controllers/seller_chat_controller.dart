import 'package:e_commerce_app/consts/consts.dart';

class ChatsSellerController extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var isLoading = false.obs;
  var friendName = Get.arguments[0]; // User's name
  var friendId = Get.arguments[1]; // User's ID
  var sellerName =
      "Seller Name"; // Replace with actual seller name or fetch dynamically
  var currentId = currentUser!.uid; // Seller's ID
  var msgController = TextEditingController();
  dynamic chatDocId;
  var chats = firestore.collection(chatsCollection);

  getChatId() async {
    isLoading(true);

    // Try to find an existing chat document with the same user and seller IDs
    await chats
        .where('users', isEqualTo: {friendId: null, currentId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            // If no chat exists, set chatDocId to null to prevent seller from starting the chat
            chatDocId = null;
          }
        });

    isLoading(false);
  }

// Sender Messages (Modified to handle proper Firestore updates)
  sendMessageSeller(String msg) async {
    if (msg.trim().isNotEmpty && chatDocId != null) {
      // Update the main chat document with the latest message info
      await chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': currentId,
      });

      // Add the message to the messages subcollection
      await chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId, // Track who sent the message
      });
    } else {
      // Show error if no existing chat exists
      Get.snackbar("Error", "You cannot send a message without a chat.");
    }
  }
}
