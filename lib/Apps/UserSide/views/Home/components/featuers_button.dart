import 'package:e_commerce_app/Apps/UserSide/views/Category/categories_details.dart';
import 'package:e_commerce_app/consts/consts.dart';

Widget featuerButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
      .box
      .white
      .roundedSM
      .padding(const EdgeInsets.all(4))
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .shadowSm
      .make()
      .onTap((() {
    Get.to(() => CategoriesDetails(title: title));
  }));
}
