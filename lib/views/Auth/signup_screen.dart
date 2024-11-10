// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app/Controllers/auth_controller.dart';
import 'package:e_commerce_app/views/Home/home.dart';

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
  var controller = Get.put(AuthController());

  // Text Controller

  var nameCotroller = TextEditingController();
  var emailCotroller = TextEditingController();
  var passwordCotroller = TextEditingController();
  var retypepasswordCotroller = TextEditingController();
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
              customTextField(name, nameHint, nameCotroller, false),
              customTextField(email, emailhint, emailCotroller, false),
              customTextField(password, passwordhint, passwordCotroller, true),
              customTextField(
                  retypepass, passwordhint, retypepasswordCotroller, true),
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
                onPressed: () async {
                  if (isCheak != false) {
                    try {
                      await controller
                          .signUpMethod(
                        context: context,
                        email: emailCotroller.text,
                        password: passwordCotroller.text,
                      )
                          .then((value) {
                        return controller.storeUserData(
                          name: nameCotroller.text,
                          email: emailCotroller.text,
                          password: passwordCotroller.text,
                        );
                      }).then((value) {
                        VxToast.show(context, msg: loggedin);
                        Get.offAll(() => const Home());
                      });
                    } catch (e) {
                      auth.signOut();

                      VxToast.show(context, msg: e.toString());
                    }
                  }
                },
              ).box.width(context.screenWidth - 50).make(),
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
