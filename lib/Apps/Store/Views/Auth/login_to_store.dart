// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app/Apps/Store/Controllers/store_auth_controller.dart';
import 'package:e_commerce_app/Apps/Store/Views/Auth/create_store.dart';
import 'package:e_commerce_app/Apps/Store/Views/Home/storehome.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Splash_Screen/splashscreen.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/applogo_widgets.dart';
import 'package:e_commerce_app/widgets/basic_button.dart';
import 'package:e_commerce_app/widgets/bg_widget.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class LoginToStore extends StatelessWidget {
  const LoginToStore({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(StoreHomeController());
    return SafeArea(
      child: bgWidget(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: normalText(text: welcome, size: 18.0),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: boldText(text: "HOME", size: 16.0).onTap(() {
                  Get.offAll(() => SplashScreen());
                }),
              )
            ],
          ),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Stack(alignment: Alignment.center, children: [
                      applogoWidget(),
                      Center(
                        child: boldText(text: "Z", size: 18.0),
                      )
                    ]),
                    10.widthBox,
                    boldText(text: sellerappname, size: 18.0)
                  ]),
                  30.heightBox,
                  normalText(
                      text: "Login to your account",
                      size: 18.0,
                      color: lightGrey),
                  15.heightBox,
                  Obx(
                    () => Center(
                      child: Column(
                        children: [
                          //Email Text field
                          customTextField(
                              prefix: Icon(
                                Icons.email,
                                color: redColor,
                              ),
                              isFilled: false,
                              textColor: darkFontGrey,
                              borderColor: redColor,
                              title: email,
                              hint: emailhint,
                              controller: controller.emailController,
                              isPass: false),
                          //Password Text field
                          customTextField(
                              prefix: Icon(
                                Icons.lock,
                                color: redColor,
                              ),
                              isFilled: false,
                              borderColor: redColor,
                              textColor: darkFontGrey,
                              title: password,
                              hint: passwordhint,
                              controller: controller.passwordController,
                              isPass: true),
                          //Forget Button
                          Align(
                              alignment: Alignment.centerRight,
                              //Forget Password Button
                              child: TextButton(
                                  onPressed: () {},
                                  child: normalText(
                                      text: forgotPassword, color: redColor))),
                          5.heightBox,
                          //Circular Indicator
                          controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(redColor),
                                )
                              //LogIn Button
                              : myButton(
                                      color: redColor,
                                      title: "LogIn To Store",
                                      textColor: lightgolden,
                                      onPressed: () async {
                                        controller.isLoading(true);
                                        await controller
                                            .loginToStore(context: context)
                                            .then((value) {
                                          VxToast.show(context,
                                              msg: "logged In");
                                          controller.isLoading(false);
                                          Get.to(() => StoreHome());
                                        });
                                      })
                                  .box
                                  .width(context.screenWidth - 100)
                                  .make(),
                          5.heightBox,
                          createNewStore.text.color(fontGrey).make(),
                          5.heightBox,
                          // Singup Button
                          myButton(
                              color: lightgolden,
                              title: "Create Store Account",
                              textColor: redColor,
                              onPressed: () {
                                Get.to(() => CreateStoreAccount());
                              }).box.width(context.screenWidth - 100).make(),
                        ],
                      )
                          .box
                          .white
                          .rounded
                          .padding(const EdgeInsets.all(16))
                          .width(context.screenWidth - 20)
                          .shadowSm
                          .make(),
                    ),
                  ),
                  20.heightBox,
                  Center(
                    child: normalText(text: anyProblem, color: lightGrey),
                  ),
                  SizedBox(height: context.screenHeight * 0.22),
                  Center(child: normalText(text: credits)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
