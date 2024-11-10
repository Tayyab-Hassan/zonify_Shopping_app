import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../consts/list.dart';
import '../../widgets/applogo_widgets.dart';
import '../../widgets/basic_button.dart';
import '../../widgets/bg_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../Home/home.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log In To $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Column(
              children: [
                //Email Text field
                customTextField(email, emailhint, null),
                //Password Text field
                customTextField(password, passwordhint, null),
                //Forget Button
                Align(
                    alignment: Alignment.centerRight,
                    //Forget Password Button
                    child: TextButton(
                        onPressed: () {}, child: forgetPassword.text.make())),
                5.heightBox,
                //LogIn Button
                myButton(
                    color: redColor,
                    title: login,
                    textColor: whiteColor,
                    onPressed: () {
                      Get.to(() => const Home());
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 25,
                              child: Image.asset(
                                socialIconList[index],
                                width: 30,
                              ),
                            ),
                          )),
                )
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make()
          ],
        ),
      ),
    ));
  }
}
