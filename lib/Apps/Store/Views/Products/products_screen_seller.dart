// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app/Apps/Store/Controllers/porduct_seller_controller.dart';
import 'package:e_commerce_app/Apps/Store/Views/Products/add_products.dart';
import 'package:e_commerce_app/Apps/Store/Views/Products/products_details_seller.dart';
import 'package:e_commerce_app/Services/store_services.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/list.dart';
import 'package:e_commerce_app/widgets/appbar.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class StoreProductsScreen extends StatelessWidget {
  const StoreProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductSellerController());
    return Scaffold(
        floatingActionButton: FloatingActionButton.small(
          backgroundColor: redColor,
          onPressed: () async {
            await controller.getCateories();
            controller.populateCategroy();
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
                if (data.isEmpty) {
                  return Center(
                    child: normalText(
                        text: "No Products Added Yet!", color: darkFontGrey),
                  );
                } else {
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ListView(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                            data.length,
                            (index) => Card(
                              elevation: 3,
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                tileColor: white,
                                onTap: () {
                                  Get.to(() => PorductsDetailsSeller(
                                        data: {
                                          'id': data[index]
                                              .id, // Add the document ID
                                          ...data[index].data() as Map<String,
                                              dynamic>, // Include all fields
                                        },
                                      ));
                                },
                                leading: Image.network(
                                    data[index]['p_images'][0],
                                    width: 100,
                                    height: 150,
                                    fit: BoxFit.contain),
                                title: boldText(
                                    text: '${data[index]['p_name']}',
                                    color: darkFontGrey),
                                subtitle: Row(
                                  children: [
                                    normalText(
                                        text: currencyFormat
                                            .format(data[index]['p_price']),
                                        color: const Color.fromARGB(
                                            255, 243, 139, 139)),
                                    18.widthBox,
                                    data[index]['is_featured']
                                        ? Row(
                                            children: [
                                              Image.asset(
                                                icCompaigns,
                                                width: 20,
                                                color: redColor,
                                              ),
                                              5.widthBox,
                                              normalText(
                                                  text: feactured, color: green)
                                            ],
                                          )
                                        : Container()
                                  ],
                                ),
                                trailing: VxPopupMenu(
                                    arrowSize: 0.0,
                                    menuBuilder: () => Column(
                                          children: List.generate(
                                            3,
                                            (i) => Card(
                                              color: whiteColor,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      popMenuIconList[i],
                                                      width: 25,
                                                      color: data[index][
                                                                      'featured_id'] ==
                                                                  currentUser!
                                                                      .uid &&
                                                              i == 0
                                                          ? redColor
                                                          : darkFontGrey,
                                                    ),
                                                    10.widthBox,
                                                    normalText(
                                                        text: data[index][
                                                                        'featured_id'] ==
                                                                    currentUser!
                                                                        .uid &&
                                                                i == 0
                                                            ? "Remove Feature"
                                                            : popMenuTitleList[
                                                                i],
                                                        color: data[index][
                                                                        'featured_id'] ==
                                                                    currentUser!
                                                                        .uid &&
                                                                i == 0
                                                            ? green
                                                            : darkFontGrey),
                                                  ],
                                                ).onTap(() async {
                                                  await controller
                                                      .checkForFeaturedProduct(
                                                          data);

                                                  print(
                                                      "IsFeatured Product: ${controller.isFeatured}");

                                                  switch (i) {
                                                    case 0:
                                                      // Check if the product is already featured
                                                      if (data[index]
                                                              ['is_featured'] ==
                                                          true) {
                                                        // Remove the product from featured
                                                        await controller
                                                            .removeFeatured(
                                                                data[index].id);
                                                        VxToast.show(context,
                                                            msg:
                                                                "Removed from Featured");
                                                      } else {
                                                        // Add the product to featured only if no other product is featured
                                                        if (controller
                                                                .isFeatured
                                                                .value ==
                                                            0) {
                                                          await controller
                                                              .addFeatured(
                                                                  data[index]
                                                                      .id,
                                                                  context);
                                                          VxToast.show(context,
                                                              msg:
                                                                  "Added to Featured");
                                                        } else {
                                                          VxToast.show(context,
                                                              msg:
                                                                  "You already have a Featured Product");
                                                        }
                                                      }
                                                      break;

                                                    case 1:
                                                      // Handle other actions for case 1
                                                      break;

                                                    case 2:
                                                      // Remove product from Firestore
                                                      await controller
                                                          .removeProduct(
                                                              data[index].id);
                                                      VxToast.show(context,
                                                          msg:
                                                              "Product Removed");
                                                      break;

                                                    default:
                                                      // Handle unexpected cases
                                                      VxToast.show(context,
                                                          msg:
                                                              "Invalid Option");
                                                  }
                                                }),
                                              ),
                                            ),
                                          ),
                                        )
                                            .box
                                            .width(200)
                                            .white
                                            .rounded
                                            .shadowMd
                                            .make(),
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
                  );
                }
              }
            }));
  }
}
