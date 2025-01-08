import 'package:e_commerce_app/Apps/Store/Views/Orders/order_details_seller.dart';
import 'package:e_commerce_app/Services/store_services.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/appbar.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';
import 'package:e_commerce_app/widgets/text_style.dart';
import 'package:intl/intl.dart ' as intl;

class StoreOrdersScreen extends StatelessWidget {
  const StoreOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: myAppBar(title: sOrder),
        body: StreamBuilder(
            stream: StoreServices.getOrders(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndictor(),
                );
              } else {
                var data = snapshot.data!.docs;
                if (data.isEmpty) {
                  return Center(
                    child:
                        normalText(text: "No Orders Yet!", color: darkFontGrey),
                  );
                } else {
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ListView(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(data.length, (index) {
                            var time = data[index]['order_date'].toDate();
                            return Card(
                              elevation: 5,
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                tileColor: white,
                                onTap: () {
                                  Get.to(() => OrderDetailsSeller(
                                        data: {
                                          'id': data[index]
                                              .id, // Add the document ID
                                          ...data[index].data() as Map<String,
                                              dynamic>, // Include all fields
                                        },
                                      ));
                                },
                                title: boldText(
                                    text: "${data[index]['order_code']}",
                                    color: purpleColor),
                                subtitle: Column(
                                  children: [
                                    10.heightBox,
                                    Row(
                                      children: [
                                        Image.asset(
                                          icCalender,
                                          width: 35,
                                        ),
                                        10.widthBox,
                                        boldText(
                                            color: fontGrey,
                                            text: intl.DateFormat(
                                                    'EEE, MMM, d, ' 'yyy')
                                                .format(time)),
                                      ],
                                    ),
                                    10.heightBox,
                                    Row(
                                      children: [
                                        Image.asset(
                                          icWallet,
                                          width: 23,
                                          color: darkFontGrey,
                                        ),
                                        10.widthBox,
                                        boldText(text: unpaid, color: redColor),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: boldText(
                                    text: currencyFormat
                                        .format(data[index]['total_amount']),
                                    color: redColor),
                              ).box.margin(EdgeInsets.only(bottom: 4)).make(),
                            );
                          }),
                        )
                      ],
                    ),
                  );
                }
              }
            }));
  }
}
