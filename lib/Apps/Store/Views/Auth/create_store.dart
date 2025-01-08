// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app/Apps/Store/Controllers/store_auth_controller.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/applogo_widgets.dart';
import 'package:e_commerce_app/widgets/basic_button.dart';
import 'package:e_commerce_app/widgets/bg_widget.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';

class CreateStoreAccount extends StatefulWidget {
  const CreateStoreAccount({super.key});

  @override
  State<CreateStoreAccount> createState() => _CreateStoreAccountState();
}

class _CreateStoreAccountState extends State<CreateStoreAccount> {
  bool? isCheak = false;
  var controller = Get.put(StoreHomeController());

  @override
  Widget build(BuildContext context) {
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
              10.heightBox,
              "Create $appname Store Account"
                  .text
                  .fontFamily(bold)
                  .white
                  .size(18)
                  .make(),
              15.heightBox,
              Obx(
                () => Column(children: [
                  customTextField(
                      title: name,
                      hint: nameHint,
                      controller: controller.vendorName,
                      isPass: false),
                  customTextField(
                      title: email,
                      hint: emailhint,
                      controller: controller.emailController,
                      isPass: false),
                  customTextField(
                      title: password,
                      hint: passwordhint,
                      controller: controller.passwordController,
                      isPass: true),
                  customTextField(
                      title: retypepass, hint: passwordhint, isPass: true),
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
                  //Loading Indicator
                  controller.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      :
                      //SignUp Button
                      myButton(
                          color: isCheak == true ? redColor : lightGrey,
                          title: "Create",
                          textColor: whiteColor,
                          onPressed: () async {
                            controller.isLoading(true);
                            if (isCheak != false) {
                              try {
                                controller.isLoading(true);
                                await controller.checkAndCreateStore(
                                    context: context);
                              } catch (e) {
                                controller.isLoading(false);
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
                    login.text
                        .color(redColor)
                        .fontFamily(regular)
                        .make()
                        .onTap(() {
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
                    .make(),
              )

              //Sign Up Screen UI Completed...
            ],
          ),
        ),
      ),
    ));
  }
}
