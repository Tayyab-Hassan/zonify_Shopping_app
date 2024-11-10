import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../widgets/applogo_widgets.dart';
import '../../widgets/basic_button.dart';
import '../../widgets/bg_widget.dart';
import '../../widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheak = false;
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
            "Join The $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Column(children: [
              customTextField(name, nameHint, null),
              customTextField(email, emailhint, null),
              customTextField(password, passwordhint, null),
              customTextField(retypepass, passwordhint, null),
              5.heightBox,
              Row(
                children: [
                  Checkbox(
                      activeColor: redColor,
                      checkColor: whiteColor,
                      value: isCheak,
                      onChanged: (newValue) {
                        setState(() {
                          isCheak = newValue;
                        });
                      }),
                  10.widthBox,
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'I Agree to the ',
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            ),
                          ),
                          TextSpan(
                            text: termAndCondition,
                            style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            ),
                          ),
                          TextSpan(
                            text: ' & ',
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            ),
                          ),
                          TextSpan(
                            text: privacyPolicy,
                            style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              myButton(
                      color: isCheak == true ? redColor : lightGrey,
                      title: signup,
                      textColor: whiteColor,
                      onPressed: () {})
                  .box
                  .width(context.screenWidth - 50)
                  .make(),
              10.heightBox,
              // Wrapping with gesture detector of Velocity X
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                alreadyHaveAccount.text
                    .color(fontGrey)
                    .fontFamily(regular)
                    .make(),
                login.text.color(redColor).fontFamily(regular).make().onTap(() {
                  Get.back();
                }),
              ]),
            ])
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make()

            //Sign Up Screen UI Completed...
          ],
        ),
      ),
    ));
  }
}
