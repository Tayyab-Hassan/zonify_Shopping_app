import 'package:e_commerce_app/consts/consts.dart';

Widget myButton({onPressed, color, textColor, title}) {
  return ElevatedButton(
      style: ButtonStyle(
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: WidgetStatePropertyAll(color),
          padding: const WidgetStatePropertyAll(EdgeInsets.all(10))),
      onPressed: onPressed,
      child: Text(title, style: TextStyle(fontFamily: bold, color: textColor)));
}
