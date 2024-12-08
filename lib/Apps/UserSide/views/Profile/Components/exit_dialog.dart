import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/basic_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            myButton(
                color: redColor,
                onPressed: () {
                  SystemNavigator.pop();
                },
                textColor: whiteColor,
                title: "Yes"),
            myButton(
                color: redColor,
                onPressed: () {
                  Navigator.pop(context);
                },
                textColor: whiteColor,
                title: "No"),
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}
