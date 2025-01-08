import 'package:e_commerce_app/Apps/Store/Controllers/order_seller_controller.dart';
import 'package:e_commerce_app/Apps/Store/Views/Orders/Components/order_confirmation.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Orders/components/placed_order_detail.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/basic_button.dart';
import 'package:e_commerce_app/widgets/bg_widget.dart';
import 'package:e_commerce_app/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetailsSeller extends StatefulWidget {
  final dynamic data;
  const OrderDetailsSeller({super.key, this.data});

  @override
  State<OrderDetailsSeller> createState() => _OrderDetailsSellerState();
}

class _OrderDetailsSellerState extends State<OrderDetailsSeller> {
  var controller = Get.put(OrderSellerController());

  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.onDelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Obx(
        () => Scaffold(
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
            bottomNavigationBar: Visibility(
                visible: !controller.confirmedOder.value,
                child: SizedBox(
                  height: 60,
                  width: context.screenWidth,
                  child: myButton(
                      color: green,
                      onPressed: () {
                        controller.confirmedOder(true);
                      },
                      title: "Confirm Order",
                      textColor: white),
                )),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Visibility(
                    visible: !controller.confirmedOder.value,
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
                              value: controller.confirmed.value,
                              onChanged: (value) {
                                controller.confirmed.value = value;
                                controller.changeStatus(
                                    title: 'order_confirmed',
                                    status: value,
                                    docId: widget.data["id"]);
                              },
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
                              value: controller.onDelivery.value,
                              onChanged: (value) {
                                controller.onDelivery.value = value;

                                controller.changeStatus(
                                    title: 'order_on_delivery',
                                    status: value,
                                    docId: widget.data['id']);
                              },
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
                              value: controller.delivered.value,
                              onChanged: (value) {
                                controller.delivered.value = value;

                                controller.changeStatus(
                                    title: 'order_delivered',
                                    status: value,
                                    docId: widget.data['id']);
                              },
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
                              d1: "${widget.data['order_code']}",
                              title2: 'Shipping Method',
                              d2: "${widget.data['shipping_method']}"),
                          10.heightBox,
                          orderPlaceDetails(
                              title1: 'Order Date',
                              d1: intl.DateFormat()
                                  .add_yMd()
                                  .format((widget.data['order_date'].toDate())),
                              title2: 'Payment Method',
                              d2: "${widget.data['payment_method']}"),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      10.heightBox,
                                      "Sipping Address"
                                          .text
                                          .fontFamily(semibold)
                                          .make(),
                                      "${widget.data['order_by_name']}"
                                          .text
                                          .make(),
                                      "${widget.data['order_by_email']}"
                                          .text
                                          .make(),
                                      "${widget.data['order_by_address']}"
                                          .text
                                          .make(),
                                      "${widget.data['order_by_city']}"
                                          .text
                                          .make(),
                                      "${widget.data['order_by_state']}"
                                          .text
                                          .make(),
                                      "${widget.data['order_by_phone']}"
                                          .text
                                          .make(),
                                      "${widget.data['order_by_postalcode']}"
                                          .text
                                          .make(),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      "Total Amount"
                                          .text
                                          .fontFamily(semibold)
                                          .make(),
                                      20.heightBox,
                                      currencyFormat
                                          .format(widget.data['total_amount'])
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
                          children:
                              List.generate(controller.orders.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  orderPlaceDetails(
                                    title1:
                                        "${controller.orders[index]['title']}",
                                    title2: currencyFormat.format(
                                        controller.orders[index]['tPrice']),
                                    d1: "${controller.orders[index]['quantity']}x",
                                    d2: "Refundable",
                                    textColor: redColor,
                                  ),
                                  5.heightBox,
                                  Container(
                                    width: 30,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Color(
                                          controller.orders[index]['color']),
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
      ),
    );
  }
}
