import 'package:e_commerce_app/Apps/Store/Controllers/porduct_seller_controller.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

Widget porductDropDown(
    {hint,
    required List<String> list,
    dropvalue,
    required ProductSellerController controller}) {
  return Obx(
    () => DropdownButtonHideUnderline(
        child: DropdownButton(
            hint: normalText(text: hint, color: fontGrey).marginAll(10),
            value: dropvalue.value == '' ? null : dropvalue.value,
            isExpanded: true,
            items: list.map((e) {
              return DropdownMenuItem(
                value: e,
                child: e.toString().text.make(),
              );
            }).toList(),
            onChanged: (value) {
              if (hint == "Category") {
                controller.subCategoryValue.value = '';
                controller.populateSubCategroy(value.toString());
              }
              dropvalue.value = value.toString();
            }).box.roundedSM.color(lightGrey).make()),
  );
}
