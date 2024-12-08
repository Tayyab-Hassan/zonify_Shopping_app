import 'package:e_commerce_app/consts/consts.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return Container(
    padding: const EdgeInsets.all(12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 35,
          height: 35,
          child: Stack(
            children: [
              Image.asset(icRectangleFram, width: 35, color: color),
              Center(
                child: Image.asset(icon, width: 25, color: color),
              )
            ],
          ),
        ),
        20.widthBox,
        Expanded(
          child: Container(
            height: 3,
            color: lightGrey,
          ),
        ),
        30.widthBox,
        "$title".text.fontFamily(semibold).color(darkFontGrey).make(),
        20.widthBox,
        Image.asset(
          icConfrim,
          width: 25,
          color: showDone ? null : lightGrey,
        )
      ],
    ),
  );
}
