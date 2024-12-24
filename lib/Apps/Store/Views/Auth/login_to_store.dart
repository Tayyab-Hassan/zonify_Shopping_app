import 'package:e_commerce_app/Apps/Store/Views/Home/storehome.dart';
import 'package:e_commerce_app/Apps/UserSide/Controllers/auth_controller.dart';
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
    var controller = Get.put(AuthController());
    return SafeArea(
      child: bgWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.heightBox,
                  normalText(text: welcome, size: 18.0),
                  20.heightBox,
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
                  50.heightBox,
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
                          controller.isloading.value
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(redColor),
                                )
                              //LogIn Button
                              : myButton(
                                      color: redColor,
                                      title: login,
                                      textColor: lightgolden,
                                      onPressed: () {
                                        Get.to(() => StoreHome());
                                      })
                                  .box
                                  .width(context.screenWidth - 100)
                                  .make(),
                          5.heightBox,
                          createNewAccount.text.color(fontGrey).make(),
                          5.heightBox,
                          // Singup Button
                          myButton(
                                  color: lightgolden,
                                  title: signup,
                                  textColor: redColor,
                                  onPressed: () {})
                              .box
                              .width(context.screenWidth - 100)
                              .make(),
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
