import 'package:e_commerce_app/Apps/UserSide/Controllers/auth_controller.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Auth/signup_screen.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Home/home.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/applogo_widgets.dart';
import 'package:e_commerce_app/widgets/basic_button.dart';
import 'package:e_commerce_app/widgets/bg_widget.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              (context.screenHeight * 0.01).heightBox,
              applogoWidget(),
              15.heightBox,
              "Log In To $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Obx(
                () => Column(
                  children: [
                    //Email Text field
                    customTextField(
                        title: email,
                        hint: emailhint,
                        controller: controller.emailController,
                        isPass: false),
                    //Password Text field
                    customTextField(
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
                            child: forgotPassword.text.make())),
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
                            textColor: whiteColor,
                            onPressed: () async {
                              controller.isloading(true);

                              await controller
                                  .loginMethod(context: context)
                                  .then((value) {
                                if (value != null) {
                                  // ignore: use_build_context_synchronously
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                } else {
                                  controller.isloading(false);
                                }
                              });
                            }).box.width(context.screenWidth - 50).make(),
                    5.heightBox,
                    createNewAccount.text.color(fontGrey).make(),
                    5.heightBox,
                    // Singup Button
                    myButton(
                        color: lightgolden,
                        title: signup,
                        textColor: redColor,
                        onPressed: () {
                          Get.to(() => const SignupScreen());
                        }).box.width(context.screenWidth - 50).make(),
                    10.heightBox,
                    loginWith.text.color(fontGrey).make(),
                    //LogIn With SoailApp
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: controller.isloadingwithGoogle.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(fontGrey),
                            )
                          //LogIn Button
                          : CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 25,
                              child: Image.asset(
                                icGoogleLogo,
                                width: 30,
                              ),
                            ),
                    ).onTap(() async {
                      controller.isloadingwithGoogle(true);
                      await controller.signInWithGoogle();
                      controller.isloadingwithGoogle(false);
                    }),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make()
                    .onTap(() {}),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
