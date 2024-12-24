import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

Widget porductDropDown({hint}) {
  return DropdownButtonHideUnderline(
      child: DropdownButton(
              hint: normalText(text: hint, color: fontGrey).marginAll(10),
              value: null,
              isExpanded: false,
              items: [],
              onChanged: (value) {})
          .box
          .roundedSM
          .color(lightGrey)
          .make());
}
