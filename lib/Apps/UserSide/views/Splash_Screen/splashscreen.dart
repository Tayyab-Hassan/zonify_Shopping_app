import 'package:e_commerce_app/Apps/UserSide/views/Auth/login_screen.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Home/home.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/applogo_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Creating a method to change Screen
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      //Using GetX
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => const LoginScreen());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg, width: 300)),
          20.heightBox,
          applogoWidget(),
          10.heightBox,
          appname.text.fontFamily(bold).size(22).white.make(),
          5.heightBox,
          appversion.text.white.make(),
          const Spacer(),
          credits.text.white.fontFamily(semibold).make(),
          30.heightBox
          // Splash UI Is Completed...
        ],
      ),
    );
  }
}
