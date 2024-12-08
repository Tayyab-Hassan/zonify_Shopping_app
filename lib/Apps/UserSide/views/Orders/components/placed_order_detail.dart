import 'package:e_commerce_app/consts/consts.dart';

Widget orderPlaceDetails({data, title1, title2, d1, d2, textColor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
              fit: BoxFit.scaleDown,
              child: "$title1".text.fontFamily(semibold).make()),
          FittedBox(
              fit: BoxFit.scaleDown,
              child: "$d1".text.color(redColor).fontFamily(semibold).make()),
        ],
      ),
      SizedBox(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
                fit: BoxFit.scaleDown,
                child: "$title2"
                    .text
                    .fontFamily(semibold)
                    .color(textColor)
                    .make()),
            FittedBox(fit: BoxFit.scaleDown, child: '$d2'.text.make())
          ],
        ),
      ),
    ],
  );
}
