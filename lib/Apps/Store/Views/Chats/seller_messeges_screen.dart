import 'package:e_commerce_app/Apps/Store/Views/Chats/seller_chat.dart';
import 'package:e_commerce_app/Services/firestore_services.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class ShopMessagsScreen extends StatelessWidget {
  const ShopMessagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        leading: BackButton(
          color: whiteColor,
        ),
        title: "My Messages".text.fontFamily(semibold).color(whiteColor).make(),
      ),
      backgroundColor: whiteColor,
      body: StreamBuilder(
          stream: FirestoreServices.getAllChats(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndictor(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return 'No Messages Yet!'.text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Get.to(() => const SellerChatScreen(),
                                      arguments: [
                                        data[index]['friend_name'],
                                        data[index]['toId']
                                      ]);
                                },
                                leading: CircleAvatar(
                                  backgroundColor: redColor,
                                  child: Image.asset(
                                    icProfile,
                                    width: 23,
                                    fit: BoxFit.cover,
                                    color: whiteColor,
                                  ),
                                ),
                                title: "${data[index]['friend_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(purpleColor)
                                    .make(),
                                subtitle:
                                    "${data[index]['last_msg']}".text.make(),
                                trailing: normalText(
                                    text: "10:45 PM", color: darkFontGrey),
                              ),
                            );
                          }))
                ],
              );
            }
          }),
    );
  }
}
