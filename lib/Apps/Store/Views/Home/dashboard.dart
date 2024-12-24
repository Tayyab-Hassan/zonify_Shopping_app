import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/appbar.dart';
import 'package:e_commerce_app/widgets/dashboard_button.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class StoreHomeScreen extends StatelessWidget {
  const StoreHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: myAppBar(title: "Dashboard"),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              dashboardButton(
                  title: products,
                  cont: "78",
                  context: context,
                  icon: icProducts),
              dashboardButton(
                  title: orders, cont: '12', context: context, icon: icSOrders)
            ]),
            10.heightBox,
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              dashboardButton(
                  title: rating, cont: "78", context: context, icon: icStar),
              dashboardButton(
                  title: totalSales,
                  cont: '12',
                  context: context,
                  icon: icSales)
            ]),
            10.heightBox,
            Divider(),
            10.heightBox,
            boldText(text: "Popular Products", size: 16.0, color: darkFontGrey),
            20.heightBox,
            ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                  3,
                  (index) => ListTile(
                        onTap: () {},
                        leading: Image.asset(icAppLogo,
                            width: 100, height: 100, fit: BoxFit.contain),
                        title: boldText(
                            text: 'Products Title', color: darkFontGrey),
                        subtitle: normalText(text: '\$40', color: fontGrey),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
