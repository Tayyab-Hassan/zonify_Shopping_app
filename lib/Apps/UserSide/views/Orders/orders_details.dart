import 'package:e_commerce_app/Apps/UserSide/views/Orders/components/order_status.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Orders/components/placed_order_detail.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: whiteColor,
        ),
        backgroundColor: redColor,
        title:
            "Orders Details".text.color(whiteColor).fontFamily(semibold).make(),
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(
                title: 'Placed',
                color: Colors.orangeAccent,
                showDone: data['order_placed'],
                icon: icCart),
            orderStatus(
                title: 'Confrimed',
                color: Colors.blue.shade800,
                showDone: data['order_confirmed'],
                icon: iclike),
            orderStatus(
                title: 'On Delivery',
                color: redColor,
                showDone: data['order_on_delivery'],
                icon: icDelivery),
            orderStatus(
                title: 'Delivered',
                color: const Color.fromARGB(255, 76, 22, 85),
                showDone: data['order_delivered'],
                icon: icWhiteTick),
            const Divider(),
            10.heightBox,
            Card(
              shadowColor: lightGrey,
              elevation: 10,
              color: whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    orderPlaceDetails(
                        title1: 'Order Code',
                        d1: data['order_code'],
                        title2: 'Shipping Method',
                        d2: data['shipping_method']),
                    10.heightBox,
                    orderPlaceDetails(
                        title1: 'Order Date',
                        d1: intl.DateFormat()
                            .add_yMd()
                            .format((data['order_date'].toDate())),
                        title2: 'Payment Method',
                        d2: data['payment_method']),
                    10.heightBox,
                    orderPlaceDetails(
                        title1: 'Payment Status',
                        d1: 'Unpaid',
                        title2: 'Delivery Status',
                        d2: 'Order Placed'),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.heightBox,
                                "Sipping Address"
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                                '${data['order_by_name']}'.text.make(),
                                '${data['order_by_email']}'.text.make(),
                                '${data['order_by_address']}'.text.make(),
                                '${data['order_by_city']}'.text.make(),
                                '${data['order_by_state']}'.text.make(),
                                '${data['order_by_phone']}'.text.make(),
                                '${data['order_by_postalcode']}'.text.make(),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Total Amount".text.fontFamily(semibold).make(),
                                20.heightBox,
                                boldText(
                                    text: currencyFormat
                                        .format(data['total_amount']),
                                    color: redColor),
                                80.heightBox,
                              ],
                            ),
                          ),
                        ])
                  ],
                ),
              ),
            ),
            10.heightBox,
            Card(
              elevation: 10,
              color: whiteColor,
              child: Column(
                children: [
                  "Ordered Products"
                      .text
                      .fontFamily(bold)
                      .size(16)
                      .color(darkFontGrey)
                      .makeCentered(),
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(data['orders'].length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            orderPlaceDetails(
                              title1: data['orders'][index]['title'],
                              title2: data['orders'][index]['tPrice'],
                              d1: "${data['orders'][index]['quantity']}x",
                              d2: "Refundable",
                              textColor: redColor,
                            ),
                            5.heightBox,
                            Container(
                              width: 30,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Color(data['orders'][index]['color']),
                              ),
                            ),
                            const Divider(
                              thickness: 3,
                              color: lightGrey,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  )
                      .box
                      .color(whiteColor)
                      .outerShadowSm
                      .margin(const EdgeInsets.only(bottom: 4))
                      .make(),
                ],
              ),
            ),
            20.heightBox,
          ],
        ),
      ),
    );
  }
}
