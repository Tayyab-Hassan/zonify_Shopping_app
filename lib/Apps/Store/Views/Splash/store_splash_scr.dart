import 'package:e_commerce_app/Apps/Store/Views/Auth/login_to_store.dart';
import 'package:e_commerce_app/Apps/Store/Views/Home/dashboard.dart';
import 'package:e_commerce_app/Apps/Store/Views/Home/storehome.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Auth/login_screen.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/applogo_widgets.dart';
import 'package:e_commerce_app/widgets/text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreSplashScreen extends StatefulWidget {
  const StoreSplashScreen({super.key});

  @override
  State<StoreSplashScreen> createState() => _StoreSplashScreenState();
}

class _StoreSplashScreenState extends State<StoreSplashScreen> {
  //Creating a method to change Screen

  void checkStoreAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    final isStoreLoggedIn = prefs.getBool('isStoreLoggedIn') ?? false;

    if (isStoreLoggedIn) {
      // Navigate to Store Home Screen if the user is already logged in
      Get.to(() => const StoreHome());
    } else {
      final user = auth.currentUser;

      if (user == null) {
        // If the user is not logged in, navigate to Main App Login Screen
        Get.to(() => const LoginScreen());
      } else {
        // Check if the store exists in the vendors collection
        final vendorDoc = await FirebaseFirestore.instance
            .collection('vendors')
            .doc(user.uid)
            .get();

        if (vendorDoc.exists) {
          // Store exists, navigate to Store Home Screen
          Get.to(() => const StoreHomeScreen());
        } else {
          // Store does not exist, navigate to Create Store Screen
          Get.to(() => const LoginToStore());
        }
      }
    }
  }

  @override
  void initState() {
    checkStoreAndNavigate();

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
          boldText(text: "Welcome to Store", size: 18.0),
          const Spacer(),
          credits.text.white.fontFamily(semibold).make(),
          30.heightBox
          // Splash UI Is Completed...
        ],
      ),
    );
  }
}
