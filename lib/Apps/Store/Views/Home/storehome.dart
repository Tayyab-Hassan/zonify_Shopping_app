import 'package:e_commerce_app/Apps/Store/Controllers/store_auth_controller.dart';
import 'package:e_commerce_app/Apps/Store/Views/Home/dashboard.dart';
import 'package:e_commerce_app/Apps/Store/Views/Orders/orders_screen_seller.dart';
import 'package:e_commerce_app/Apps/Store/Views/Products/products_screen_seller.dart';
import 'package:e_commerce_app/Apps/Store/Views/Profile/store_profile_scr.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Profile/Components/exit_dialog.dart';
import 'package:e_commerce_app/consts/consts.dart';

class StoreHome extends StatelessWidget {
  const StoreHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Int home Controller
    var controller = Get.put(StoreHomeController());
    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26, color: darkFontGrey),
          label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(icProducts, width: 26, color: darkFontGrey),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(icSOrders, width: 26, color: darkFontGrey),
          label: sOrder),
      BottomNavigationBarItem(
          icon: Image.asset(icSetting, width: 26, color: darkFontGrey),
          label: setting),
    ];

    var navBody = [
      StoreHomeScreen(),
      StoreProductsScreen(),
      StoreOrdersScreen(),
      StoreProfileScreen()
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
            Obx(() =>
                Expanded(child: navBody.elementAt(controller.navIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              currentIndex: controller.navIndex.value,
              selectedItemColor: redColor,
              unselectedItemColor: darkFontGrey,
              selectedLabelStyle: const TextStyle(fontFamily: semibold),
              type: BottomNavigationBarType.fixed,
              items: navbarItem,
              onTap: (value) {
                controller.navIndex.value = value;
              },
            )),
      ),
    );
  }
}
