import 'package:e_commerce_app/consts/consts.dart';

Widget normalText({text, color = white, size = 14.0}) {
  return "$text".text.color(color).size(size).make();
}

Widget boldText({text, color = whiteColor, size = 14.0}) {
  return "$text".text.fontFamily(bold).color(color).size(size).make();
}
