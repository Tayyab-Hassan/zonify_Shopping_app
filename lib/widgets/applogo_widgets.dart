import 'package:e_commerce_app/consts/consts.dart';

Widget applogoWidget({color}) {
//USING VILOCITY_X
  return Image.asset(
    icAppLogo,
    color: color,
  ).box.white.size(77, 77).padding(const EdgeInsets.all(8)).rounded.make();
}
