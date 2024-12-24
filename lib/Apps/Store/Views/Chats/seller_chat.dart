import 'package:e_commerce_app/Apps/UserSide/Controllers/chats_controller.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Chats/components/sender_bubble.dart';
import 'package:e_commerce_app/Services/firestore_services.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';

class SellerChatScreen extends StatelessWidget {
  const SellerChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "${controller.friendName}"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: loadingIndictor(),
                      )
                    : Expanded(
                        child: StreamBuilder(
                            stream: FirestoreServices.getAllMessages(
                                controller.chatDocId.toString()),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: loadingIndictor(),
                                );
                              } else if (snapshot.data!.docs.isEmpty) {
                                return Center(
                                  child: "Send a Message..."
                                      .text
                                      .color(darkFontGrey)
                                      .make(),
                                );
                              } else {
                                return ListView(
                                  children: snapshot.data!.docs
                                      .mapIndexed((currentValue, index) {
                                    var data = snapshot.data!.docs[index];

                                    return Align(
                                        alignment:
                                            data['uid'] == currentUser!.uid
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                        child: senderBubble(data));
                                  }).toList(),
                                );
                              }
                            })),
              ),
              10.heightBox,
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: controller.msgConttroller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey)),
                      hintText: "Type a message...",
                    ),
                  )),
                  IconButton(
                      onPressed: () {
                        controller.sendMessage(controller.msgConttroller.text);
                        controller.msgConttroller.clear();
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: redColor,
                      ))
                ],
              )
                  .box
                  .height(70)
                  .padding(const EdgeInsets.all(12))
                  .margin(const EdgeInsets.only(bottom: 8))
                  .make(),
            ],
          ),
        ));
  }
}
