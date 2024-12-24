import 'package:e_commerce_app/consts/consts.dart';

Widget orderConfrimation({color, icon, title}) {
  return Row(
    children: [
      Image.asset(icon, width: 25, color: color),
      10.widthBox,
      "$title".text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  );
}
