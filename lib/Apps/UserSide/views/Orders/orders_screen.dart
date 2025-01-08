import 'package:e_commerce_app/Apps/UserSide/views/Orders/orders_details.dart';
import 'package:e_commerce_app/Services/firestore_services.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        leading: BackButton(
          color: whiteColor,
        ),
        title: "My Orders ".text.fontFamily(semibold).color(whiteColor).make(),
      ),
      backgroundColor: whiteColor,
      body: StreamBuilder(
          stream: FirestoreServices.getAllOrder(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndictor(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return 'No Oders Yet!'.text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: "${index + 1}"
                          .text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .make(),
                      title: data[index]['order_code']
                          .toString()
                          .text
                          .color(redColor)
                          .fontFamily(semibold)
                          .make(),
                      subtitle: boldText(
                        text:
                            currencyFormat.format(data[index]['total_amount']),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            Get.to(() => OrdersDetails(
                                  data: data[index].data(),
                                ));
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: darkFontGrey,
                          )),
                    );
                  });
            }
          }),
    );
  }
}
