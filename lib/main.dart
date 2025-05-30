import 'package:e_commerce_app/Apps/UserSide/views/Splash_Screen/splashscreen.dart';
import 'package:e_commerce_app/consts/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //using GetX that why we Use GetMaterialApp
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
          iconTheme: const IconThemeData(color: darkFontGrey),
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
          ),
          fontFamily: regular),
      home: const SplashScreen(),
    );
  }
}
