import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

AppBar myAppBar({title}) {
  return AppBar(
    backgroundColor: redColor,
    automaticallyImplyLeading: false,
    title: boldText(text: title, size: 16.0, color: white),
    actions: [
      Center(
        child: normalText(
            color: white,
            text: intl.DateFormat('EEE, MMM, d, ' 'yy').format(DateTime.now())),
      ),
      10.widthBox,
    ],
  );
}
