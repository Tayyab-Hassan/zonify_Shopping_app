import 'package:e_commerce_app/consts/consts.dart';

Widget loadingIndictor() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}
