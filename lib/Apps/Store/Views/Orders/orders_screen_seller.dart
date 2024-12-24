import 'package:e_commerce_app/Apps/Store/Views/Orders/order_details_seller.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/appbar.dart';
import 'package:e_commerce_app/widgets/text_style.dart';
import 'package:intl/intl.dart ' as intl;

class StoreOrdersScreen extends StatelessWidget {
  const StoreOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: myAppBar(title: sOrder),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                  20,
                  (index) => Card(
                        elevation: 5,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          tileColor: white,
                          onTap: () {
                            Get.to(() => OrderDetailsSeller());
                          },
                          title:
                              boldText(text: '0743598234', color: purpleColor),
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
                                      text:
                                          intl.DateFormat('EEE, MMM, d, ' 'yy')
                                              .format(DateTime.now())),
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
                          trailing: boldText(text: "\$40.0", color: redColor),
                        ).box.margin(EdgeInsets.only(bottom: 4)).make(),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
