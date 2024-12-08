// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app/Apps/UserSide/Controllers/cart_controller.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Home/home.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/list.dart';
import 'package:e_commerce_app/widgets/basic_button.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Obx(
          () => controller.isPlacingOrder.value
              ? Center(
                  child: loadingIndictor(),
                )
              : myButton(
                  title: "Place My Order",
                  color: redColor,
                  textColor: whiteColor,
                  onPressed: () async {
                    await controller.placeMyOrder(
                        orderPaymentMethod: paymentMethodsStrigList[
                            controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);

                    await controller.clearCart();
                    VxToast.show(context, msg: "Order Placed Successfully");
                    Get.offAll(const Home());
                  }),
        ),
      ),
      appBar: AppBar(
        leading: BackButton(
          color: whiteColor,
        ),
        backgroundColor: redColor,
        title: "Choose Payment Method"
            .text
            .fontFamily(semibold)
            .color(whiteColor)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(
          () => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: List.generate(paymentMethodsImgList.length, (index) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.only(bottom: 8),
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: controller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 4)),
                  child: Stack(alignment: Alignment.topRight, children: [
                    Image.asset(paymentMethodsImgList[index],
                        width: double.infinity,
                        fit: BoxFit.cover,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent),
                    controller.paymentIndex.value == index
                        ? Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                                activeColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                value: true,
                                onChanged: (value) {}),
                          )
                        : Container(),
                    Positioned(
                        bottom: 5,
                        right: 10,
                        child: paymentMethodsStrigList[index]
                            .text
                            .fontFamily(semibold)
                            .color(whiteColor)
                            .make()),
                  ]),
                ).onTap(() {
                  controller.changeMethodIndex(index);
                });
              }),
            ),
          ),
        ),
      ),
    );
  }
}
