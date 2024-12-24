// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import '../../../../consts/consts.dart';
import '../../../../widgets/basic_button.dart';
import '../../../../widgets/bg_widget.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../Controllers/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: whiteColor,
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //if Data Image url and Controller path is Empty
                data['imageUrl'] == '' && controller.profileImagePath.isEmpty
                    ? CircleAvatar(
                        backgroundColor: redColor,
                        child: Image.asset(
                          icProfile,
                          width: 25,
                          fit: BoxFit.cover,
                          color: whiteColor,
                        ),
                      ).box.size(50, 50).roundedFull.clip(Clip.antiAlias).make()
                    :

                    // If Data is not Empty But Cotroller is Empty
                    data['imageUrl'] != '' &&
                            controller.profileImagePath.isEmpty
                        ? Image.network(data['imageUrl'],
                                width: 80, fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make()

                        // if both Are Empty
                        : Image.file(
                                File(
                                  controller.profileImagePath.value,
                                ),
                                width: 80,
                                fit: BoxFit.contain)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make(),
                10.heightBox,

                myButton(
                    color: redColor,
                    textColor: whiteColor,
                    title: "Change",
                    onPressed: () {
                      controller.changeImage(context);
                    }),
                20.heightBox,
                const Divider(),
                20.heightBox,
                customTextField(
                    title: name,
                    hint: nameHint,
                    controller: controller.nameController,
                    isPass: false),
                10.heightBox,
                customTextField(
                    title: oldPassword,
                    hint: oldPasswordHint,
                    controller: controller.oldPasswordController,
                    isPass: true),
                10.heightBox,
                customTextField(
                    title: newPassword,
                    hint: passwordhint,
                    controller: controller.newPasswordController,
                    isPass: true),
                20.heightBox,
                controller.isloading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: context.screenWidth - 60,
                        child: myButton(
                            color: redColor,
                            onPressed: () async {
                              controller.isloading(true);
                              //if Image is not selected
                              if (controller.profileImagePath.isNotEmpty) {
                                await controller.uploadProfileImage();
                              } else {
                                controller.profileImageLink = data['imageUrl'];
                              }

                              //Conforim Old Password Then Change Newpassword

                              if (data["password"] ==
                                  controller.oldPasswordController.text) {
                                await controller.changeAuthPassword(
                                  email: data['email'],
                                  password:
                                      controller.oldPasswordController.text,
                                  newpassword:
                                      controller.newPasswordController.text,
                                );

                                await controller.updateProfile(
                                  imgUrl: controller.profileImageLink,
                                  name: controller.nameController.text,
                                  password:
                                      controller.newPasswordController.text,
                                );
                                VxToast.show(context, msg: 'Updated');
                              } else {
                                VxToast.show(context,
                                    msg: 'Wrong Old Password');
                                controller.isloading(false);
                              }
                            },
                            textColor: whiteColor,
                            title: 'Save'))
              ],
            )
                .box
                .white
                .shadowSm
                .padding(const EdgeInsets.all(16))
                .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
                .roundedSM
                .make(),
          ),
        ),
      ),
    ));
  }
}
