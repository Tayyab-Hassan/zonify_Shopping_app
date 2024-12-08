import 'package:e_commerce_app/Apps/UserSide/Controllers/cart_controller.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Cart/payment_method.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/basic_button.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          leading: BackButton(
            color: whiteColor,
          ),
          backgroundColor: redColor,
          title: "Shipping Information"
              .text
              .fontFamily(semibold)
              .color(whiteColor)
              .make()),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: myButton(
            title: "Continue",
            color: redColor,
            textColor: whiteColor,
            onPressed: () {
              if (controller.adressController.text.trim().isEmpty ||
                  controller.cityController.text.trim().isEmpty ||
                  controller.phoneController.text.trim().isEmpty ||
                  controller.stateController.text.trim().isEmpty ||
                  controller.postalController.text.trim().isEmpty) {
                VxToast.show(context,
                    msg:
                        "Please Fill All The Form Fields"); // Corrected position of the toast
              } else {
                Get.to(() => const PaymentMethods());
              }
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              customTextField(
                  title: "Address",
                  hint: "Enter Your address",
                  isPass: false,
                  controller: controller.adressController),
              customTextField(
                  title: "City",
                  hint: "city",
                  isPass: false,
                  controller: controller.cityController),
              customTextField(
                  title: "State",
                  hint: "Enter Your State",
                  isPass: false,
                  controller: controller.stateController),
              customTextField(
                  title: "Postal Code",
                  hint: "enter your city postal code",
                  isPass: false,
                  controller: controller.postalController),
              customTextField(
                  title: "Phone",
                  hint: "+92 #######",
                  isPass: false,
                  controller: controller.phoneController),
            ],
          ),
        ),
      ),
    );
  }
}
