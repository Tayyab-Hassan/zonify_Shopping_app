import 'package:e_commerce_app/consts/consts.dart';

Widget detialsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make(),
    ],
  )
      .box
      .roundedSM
      .white
      .height(65)
      .padding(const EdgeInsets.all(4))
      .width(width)
      .make();
}
