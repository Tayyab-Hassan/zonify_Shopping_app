import 'package:e_commerce_app/consts/consts.dart';

Widget homeButtons({width, height, icon, String? tile, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      5.heightBox,
      tile!.text.color(darkFontGrey).fontFamily(semibold).make()
    ],
  ).box.rounded.color(whiteColor).shadowSm.size(width, height).make();
}
