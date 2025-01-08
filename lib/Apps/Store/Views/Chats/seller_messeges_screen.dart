import 'package:e_commerce_app/Apps/Store/Views/Chats/seller_chat.dart';
import 'package:e_commerce_app/Services/store_services.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';
import 'package:e_commerce_app/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

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
          stream: StoreServices.getAllChats(),
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
                            var t = data[index]['created_on'] == null
                                ? DateTime.now()
                                : data[index]['created_on'].toDate();
                            var time = intl.DateFormat("h:mma").format(t);
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Get.to(() => const SellerChatScreen(),
                                      arguments: [
                                        data[index]['customer_name'],
                                        data[index]['customerID']
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
                                title: "${data[index]['customer_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(purpleColor)
                                    .make(),
                                subtitle:
                                    "${data[index]['last_msg']}".text.make(),
                                trailing:
                                    normalText(text: time, color: darkFontGrey),
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
