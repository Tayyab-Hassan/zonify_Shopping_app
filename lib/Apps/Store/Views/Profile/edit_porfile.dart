// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/basic_button.dart';
import 'package:e_commerce_app/widgets/bg_widget.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';

class EditPorfileStore extends StatelessWidget {
  final dynamic data;
  const EditPorfileStore({super.key, this.data});

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
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: redColor,
                child: Image.asset(
                  icProfile,
                  width: 40,
                  fit: BoxFit.cover,
                  color: whiteColor,
                ),
              ).box.size(80, 80).roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              myButton(
                  color: redColor,
                  textColor: whiteColor,
                  title: "Change",
                  onPressed: () {}),
              20.heightBox,
              const Divider(),
              20.heightBox,
              customTextField(title: name, hint: nameHint, isPass: false),
              10.heightBox,
              customTextField(
                  title: oldPassword, hint: oldPasswordHint, isPass: true),
              10.heightBox,
              customTextField(
                  title: newPassword, hint: passwordhint, isPass: true),
              20.heightBox,
              SizedBox(
                  width: context.screenWidth - 60,
                  child: myButton(
                      color: redColor,
                      onPressed: () {},
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
    ));
  }
}
