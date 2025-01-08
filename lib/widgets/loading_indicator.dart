import 'package:e_commerce_app/consts/consts.dart';

Widget loadingIndictor({color = redColor}) {
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(color),
  );
}
