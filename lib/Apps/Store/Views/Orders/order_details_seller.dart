import 'package:e_commerce_app/Apps/Store/Views/Orders/Components/order_confirmation.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Orders/components/placed_order_detail.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/bg_widget.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class OrderDetailsSeller extends StatelessWidget {
  const OrderDetailsSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: whiteColor,
            ),
            title: "Orders Details"
                .text
                .color(whiteColor)
                .fontFamily(semibold)
                .make(),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Visibility(
                  visible: true,
                  child: Card(
                    shadowColor: lightGrey,
                    elevation: 10,
                    color: white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          boldText(
                              text: "Order Status",
                              color: darkFontGrey,
                              size: 16.0),
                          SwitchListTile(
                            activeTrackColor: lightGrey,
                            inactiveTrackColor: lightGrey,
                            inactiveThumbColor: fontGrey,
                            activeThumbImage: AssetImage(
                              icConfrim,
                            ),
                            title: orderConfrimation(
                                color: Colors.orangeAccent,
                                icon: icCart,
                                title: 'Placed'),
                            value: true,
                            onChanged: (value) {},
                          ),
                          SwitchListTile(
                            activeTrackColor: lightGrey,
                            inactiveTrackColor: lightGrey,
                            inactiveThumbColor: fontGrey,
                            activeThumbImage: AssetImage(
                              icConfrim,
                            ),
                            title: orderConfrimation(
                              color: Colors.blue.shade800,
                              icon: iclike,
                              title: 'Confrimed',
                            ),
                            value: false,
                            onChanged: (value) {},
                          ),
                          SwitchListTile(
                            activeTrackColor: lightGrey,
                            inactiveTrackColor: lightGrey,
                            inactiveThumbColor: fontGrey,
                            activeThumbImage: AssetImage(
                              icConfrim,
                            ),
                            title: orderConfrimation(
                                color: redColor,
                                icon: icDelivery,
                                title: 'On Delivery'),
                            value: false,
                            onChanged: (value) {},
                          ),
                          SwitchListTile(
                            activeTrackColor: lightGrey,
                            inactiveTrackColor: lightGrey,
                            inactiveThumbColor: fontGrey,
                            activeThumbImage: AssetImage(
                              icConfrim,
                            ),
                            title: orderConfrimation(
                                color: purpleColor,
                                icon: icWhiteTick,
                                title: 'Delivered'),
                            value: true,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
                            d1: "data['order_code']",
                            title2: 'Shipping Method',
                            d2: "data['shipping_method']"),
                        10.heightBox,
                        orderPlaceDetails(
                            title1: 'Order Date',
                            // d1: intl.DateFormat()
                            //     .add_yMd()
                            //     .format((data['order_date'].toDate())),
                            title2: 'Payment Method',
                            d2: "data['payment_method']"),
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
                                    "'{data['order_by_name']}'".text.make(),
                                    "'{data['order_by_email']}'".text.make(),
                                    "'{data['order_by_address']}'".text.make(),
                                    "'{data['order_by_city']}'".text.make(),
                                    "'{data['order_by_state']}'".text.make(),
                                    "'{data['order_by_phone']}'".text.make(),
                                    "'{data['order_by_postalcode']}'"
                                        .text
                                        .make(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "Total Amount"
                                        .text
                                        .fontFamily(semibold)
                                        .make(),
                                    20.heightBox,
                                    "'{data['total_amount']}'"
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .make(),
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
                        children: List.generate(10, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                orderPlaceDetails(
                                  title1: "data['orders'][index]['title']",
                                  title2: " data['orders'][index]['tPrice']",
                                  d1: "{data['orders'][index]['quantity']}x",
                                  d2: "Refundable",
                                  textColor: redColor,
                                ),
                                5.heightBox,
                                Container(
                                  width: 30,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: purpleColor,
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
          )),
    );
  }
}
