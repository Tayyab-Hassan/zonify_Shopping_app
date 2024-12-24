import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

Widget dashboardButton({title, cont, context, icon}) {
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: title, size: 16.0),
            normalText(text: cont, size: 20.0),
          ],
        ),
      ),
      Image.asset(
        icon,
        width: 35,
        color: whiteColor,
        fit: BoxFit.contain,
      )
    ],
  )
      .box
      .color(redColor)
      .rounded
      .size(size.width * 0.4, 80)
      .padding(EdgeInsets.all(10))
      .make();
}
