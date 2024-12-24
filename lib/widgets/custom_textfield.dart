import 'package:e_commerce_app/consts/consts.dart';

Widget customTextField(
    {String? title,
    String? hint,
    suffix,
    prefix,
    controller,
    isFilled = true,
    isPass,
    isDes = false,
    textColor = redColor,
    borderColor = redColor}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(textColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      Row(
        children: [
          Container(
            child: prefix,
          ),
          10.widthBox,
          Expanded(
            child: TextFormField(
              maxLines: isDes ? 4 : 1,
              obscureText: isPass,
              controller: controller,
              decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(
                    fontFamily: semibold,
                    color: fontGrey,
                  ),
                  isDense: true,
                  fillColor: lightGrey,
                  filled: isFilled,
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor))),
            ),
          ),
        ],
      ),
      5.heightBox
    ],
  );
}
