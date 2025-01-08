// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:e_commerce_app/Apps/Store/Controllers/setting_controller.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/basic_button.dart';
import 'package:e_commerce_app/widgets/bg_widget.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';

class EditPorfileStore extends StatefulWidget {
  final String? username;
  const EditPorfileStore({super.key, this.username});

  @override
  State<EditPorfileStore> createState() => _EditPorfileStoreState();
}

class _EditPorfileStoreState extends State<EditPorfileStore> {
  var controller = Get.find<SettingController>();
  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: whiteColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              children: [
                //if Data Image url and Controller path is Empty
                controller.snapshotData['image'] == '' &&
                        controller.profileImagePath.isEmpty
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
                    controller.snapshotData['image'] != '' &&
                            controller.profileImagePath.isEmpty
                        ? Image.network(controller.snapshotData['image'],
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
                    isPass: false,
                    controller: controller.nameController),
                10.heightBox,
                customTextField(
                    title: oldPassword,
                    hint: oldPasswordHint,
                    isPass: true,
                    controller: controller.oldPasswordController),
                10.heightBox,
                customTextField(
                    title: newPassword,
                    hint: passwordhint,
                    isPass: true,
                    controller: controller.newPasswordController),
                20.heightBox,
                SizedBox(
                    width: context.screenWidth - 60,
                    child: controller.isloading.value
                        ? Center(child: loadingIndictor())
                        : myButton(
                            color: redColor,
                            onPressed: () async {
                              controller.isloading(true);
                              //if Image is not selected
                              if (controller.profileImagePath.isNotEmpty) {
                                await controller.uploadProfileImage();
                              } else {
                                controller.profileImageLink =
                                    controller.snapshotData['image'];
                              }

                              //Conforim Old Password Then Change Newpassword

                              if (controller.snapshotData["password"] ==
                                  controller.oldPasswordController.text) {
                                await controller.updateStoreAccount(
                                  context: context,
                                  imgUrl: controller.profileImageLink,
                                  name: controller.nameController.text,
                                  password:
                                      controller.newPasswordController.text,
                                );
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
