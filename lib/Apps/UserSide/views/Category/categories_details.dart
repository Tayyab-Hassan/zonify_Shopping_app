import 'package:e_commerce_app/Apps/UserSide/Controllers/products_controller.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Category/items_details.dart';
import 'package:e_commerce_app/Services/firestore_services.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/bg_widget.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';

class CategoriesDetails extends StatefulWidget {
  final String? title;
  const CategoriesDetails({super.key, required this.title});

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  @override
  void initState() {
    super.initState();
    swichCategory(widget.title);
  }

  var controller = Get.find<ProductsController>();
  dynamic productMethods;

  swichCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethods = FirestoreServices.getsubCategoryProducts(title);
    } else {
      productMethods = FirestoreServices.getProducts(title);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    print("Title: ${widget.title}");
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: whiteColor,
              ),
              title: widget.title!.text.fontFamily(bold).white.make(),
            ),
            body: SingleChildScrollView(
              physics:
                  const BouncingScrollPhysics(), // Enable vertical scrolling
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    // Subcategories Scrolling Row
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            controller.subcat.length,
                            (index) => "${controller.subcat[index]}"
                                    .text
                                    .size(12)
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .makeCentered()
                                    .box
                                    .white
                                    .roundedSM
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .size(120, 60)
                                    .make()
                                    .onTap(() {
                                  swichCategory("${controller.subcat[index]}");
                                  setState(() {});
                                })),
                      ),
                    ),
                    30.heightBox,
                    // StreamBuilder for Products Grid
                    StreamBuilder(
                        stream: productMethods,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: loadingIndictor());
                          } else if (snapshot.data!.docs.isEmpty) {
                            return "No Products Found!"
                                .text
                                .color(whiteColor)
                                .makeCentered();
                          } else {
                            var data = snapshot.data!.docs;
                            return GridView.builder(
                                shrinkWrap: true,
                                physics:
                                    const NeverScrollableScrollPhysics(), // Prevent internal scroll
                                itemCount: data.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            MediaQuery.of(context).size.width >
                                                    600
                                                ? 3
                                                : 2,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        childAspectRatio: 2 / 3),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Image.network(
                                            data[index]['p_images'][0],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      10.heightBox,
                                      "${data[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      currencyFormat
                                          .format(data[index]['p_price'])
                                          .text
                                          .fontFamily(semibold)
                                          .color(redColor)
                                          .size(16)
                                          .make()
                                    ],
                                  )
                                      .box
                                      .padding(const EdgeInsets.all(12))
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .white
                                      .roundedSM
                                      .shadowSm
                                      .make()
                                      .onTap(() {
                                    controller.checkIsFev(data[index]);
                                    Get.to(
                                      () => ItemsDetails(
                                        title: data[index]['p_name'],
                                        data: data[index],
                                        docId: data[index].id,
                                      ),
                                    );
                                  });
                                });
                          }
                        }),
                  ],
                ),
              ),
            )));
  }
}
