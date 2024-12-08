import 'package:e_commerce_app/Apps/UserSide/Controllers/home_controller.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Cart/cart_screen.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Category/category_screen.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Home/home_screen.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Profile/Components/exit_dialog.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Profile/profile_screen.dart';
import 'package:e_commerce_app/consts/consts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Int home Controller
    var controller = Get.put(HomeController());
    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: account),
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen()
    ];
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        } else {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return exitDialog(context);
              });
        }
      },
      canPop: false,
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              currentIndex: controller.currentNavIndex.value,
              selectedItemColor: redColor,
              selectedLabelStyle: const TextStyle(fontFamily: semibold),
              type: BottomNavigationBarType.fixed,
              backgroundColor: whiteColor,
              items: navbarItem,
              onTap: (value) {
                controller.currentNavIndex.value = value;
              },
            )),
      ),
    );
  }
}
