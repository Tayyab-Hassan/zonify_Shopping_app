import 'package:e_commerce_app/Apps/Store/Controllers/store_auth_controller.dart';
import 'package:e_commerce_app/Services/store_services.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/appbar.dart';
import 'package:e_commerce_app/widgets/dashboard_button.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class StoreHomeScreen extends StatelessWidget {
  const StoreHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreHomeController controller = Get.find<StoreHomeController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: myAppBar(title: "Dashboard"),
      body: StreamBuilder(
          stream: StoreServices.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndictor(),
              );
            } else {
              var data = snapshot.data!.docs;
              var n = data.sortedBy((a, b) =>
                  b["p_wishlist"].length.compareTo(a['p_wishlist'].length));
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            dashboardButton(
                                title: products,
                                cont: controller.productCount.toString(),
                                context: context,
                                icon: icProducts),
                            dashboardButton(
                                title: orders,
                                cont: controller.orderCount.toString(),
                                context: context,
                                icon: icSOrders)
                          ]),
                      10.heightBox,
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            dashboardButton(
                                title: rating,
                                cont:
                                    controller.averageRating.toStringAsFixed(1),
                                context: context,
                                icon: icStar),
                            dashboardButton(
                                title: totalSales,
                                cont: controller.totalSales.toString(),
                                context: context,
                                icon: icSales)
                          ]),
                      10.heightBox,
                      Divider(),
                      10.heightBox,
                      boldText(
                          text: "Popular Products",
                          size: 16.0,
                          color: darkFontGrey),
                      20.heightBox,
                      ListView(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            n.length,
                            (index) => n[index]['p_wishlist'].length == 0
                                ? SizedBox()
                                : ListTile(
                                    onTap: () {},
                                    leading: Image.network(
                                        n[index]['p_images'][0],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.contain),
                                    title: boldText(
                                        text: n[index]['p_name'],
                                        color: darkFontGrey),
                                    subtitle: normalText(
                                        text: currencyFormat
                                            .format(n[index]['p_price']),
                                        color: fontGrey),
                                  )),
                      )
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
