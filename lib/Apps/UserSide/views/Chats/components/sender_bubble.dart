import 'package:e_commerce_app/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Directionality(
    textDirection:
        data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: data['uid'] == currentUser!.uid ? redColor : lightgolden,
        borderRadius: data['uid'] == currentUser!.uid
            ? const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))
            : const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "${data['msg']}"
                .text
                .color(
                    data['uid'] == currentUser!.uid ? whiteColor : darkFontGrey)
                .size(16)
                .make(),
            10.heightBox,
            time.text
                .color(data['uid'] == currentUser!.uid
                    ? whiteColor.withOpacity(0.5)
                    : darkFontGrey.withOpacity(0.5))
                .make()
          ],
        ),
      ),
    ),
  );
}
