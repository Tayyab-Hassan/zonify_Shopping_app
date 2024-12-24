import 'package:e_commerce_app/Apps/Store/Views/Products/add_products.dart';
import 'package:e_commerce_app/Apps/Store/Views/Products/products_details_seller.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/list.dart';
import 'package:e_commerce_app/widgets/appbar.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class StoreProductsScreen extends StatelessWidget {
  const StoreProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: redColor,
        onPressed: () {
          Get.to(() => AddProducts());
        },
        child: Image.asset(
          icAdd,
          width: 18,
          color: white,
        ),
      ),
      backgroundColor: textfieldGrey,
      appBar: myAppBar(title: "All Porducts"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                20,
                (index) => Card(
                  elevation: 3,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor: white,
                    onTap: () {
                      Get.to(() => PorductsDetailsSeller());
                    },
                    leading: Image.asset(imgP6,
                        width: 100, height: 150, fit: BoxFit.contain),
                    title:
                        boldText(text: 'Products Title', color: darkFontGrey),
                    subtitle: Row(
                      children: [
                        normalText(text: '\$40', color: fontGrey),
                        18.widthBox,
                        Image.asset(
                          icCompaigns,
                          width: 20,
                          color: redColor,
                        ),
                        5.widthBox,
                        normalText(text: feactured, color: green)
                      ],
                    ),
                    trailing: VxPopupMenu(
                        arrowSize: 0.0,
                        menuBuilder: () => Column(
                              children: List.generate(
                                3,
                                (index) => Card(
                                  color: whiteColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          popMenuIconList[index],
                                          width: 25,
                                          color: darkFontGrey,
                                        ),
                                        10.widthBox,
                                        normalText(
                                            text: popMenuTitleList[index],
                                            color: darkFontGrey),
                                      ],
                                    ).onTap(() {}),
                                  ),
                                ),
                              ),
                            ).box.width(200).white.rounded.shadowMd.make(),
                        clickType: VxClickType.singleClick,
                        child: Image.asset(
                          icMore,
                          width: 10,
                          height: 25,
                          color: redColor,
                        )),
                  ).box.margin(EdgeInsets.only(bottom: 4)).make(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
