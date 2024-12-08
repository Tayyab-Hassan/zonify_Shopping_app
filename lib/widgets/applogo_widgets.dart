import 'package:e_commerce_app/consts/consts.dart';

Widget applogoWidget() {
//USING VILOCITY_X
  return Image.asset(icAppLogo)
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
