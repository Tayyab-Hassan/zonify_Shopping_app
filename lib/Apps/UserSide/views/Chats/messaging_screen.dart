import 'package:e_commerce_app/Apps/UserSide/views/Chats/chat_screen.dart';
import 'package:e_commerce_app/Services/firestore_services.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';

class MessagsScreen extends StatelessWidget {
  const MessagsScreen({super.key});

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
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                  onTap: () {
                                    Get.to(() => const ChatScreen(),
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
                                      .color(darkFontGrey)
                                      .make(),
                                  subtitle:
                                      "${data[index]['last_msg']}".text.make()),
                            );
                          }))
                ],
              );
            }
          }),
    );
  }
}
