import 'package:e_commerce_app/Apps/UserSide/Controllers/cart_controller.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Cart/shipping_screen.dart';
import 'package:e_commerce_app/Services/firestore_services.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/basic_button.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 60,
          child: myButton(
              title: "Proceed to Shipping",
              color: redColor,
              textColor: whiteColor,
              onPressed: () {
                Get.to(() => const ShippingDetails());
              }),
        ),
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: redColor,
          automaticallyImplyLeading: false,
          title: "Shopping Cart"
              .text
              .color(whiteColor)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndictor(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart Is Empty"
                      .text
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calulateTotal(data);
                controller.productSnapshot = data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Image.network(
                                    "${data[index]["img"]}",
                                    width: 90,
                                    fit: BoxFit.cover,
                                  ),
                                  title:
                                      "${data[index]['title']}  (x${data[index]['quantity']})"
                                          .text
                                          .fontFamily(semibold)
                                          .size(16)
                                          .make(),
                                  subtitle: normalText(
                                      text: currencyFormat
                                          .format(data[index]['tPrice']),
                                      color: redColor),
                                  trailing: IconButton(
                                      onPressed: () {
                                        controller.removeCart(data[index].id);
                                      },
                                      icon: Image.asset(
                                        icTrash,
                                        width: 22,
                                      )),
                                );
                              })),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          normalText(text: 'Total Price', color: darkFontGrey),
                          normalText(
                              text: currencyFormat
                                  .format(controller.totalP.value),
                              color: redColor),
                        ],
                      )
                          .box
                          .width(context.screenWidth - 60)
                          .padding(const EdgeInsets.all(12))
                          .color(lightgolden)
                          .roundedSM
                          .make(),
                      10.heightBox,
                    ],
                  ),
                );
              }
            }));
  }
}
