import 'package:e_commerce_app/Apps/UserSide/Controllers/products_controller.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Category/items_details.dart';
import 'package:e_commerce_app/Services/firestore_services.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: const BackButton(
          color: whiteColor,
        ),
        backgroundColor: redColor,
        title: title!.text.color(whiteColor).make(),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: FutureBuilder(
            future: FirestoreServices.searchProdusts(title),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndictor(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No Prouducts Founds"
                    .text
                    .color(darkFontGrey)
                    .fontFamily(semibold)
                    .size(16)
                    .makeCentered();
              } else {
                var data = snapshot.data!.docs
                    .where(
                      (element) => element['p_name']
                          .toString()
                          .toLowerCase()
                          .contains(title!.toLowerCase()),
                    )
                    .toList();
                print("Data :$data");
                if (data.isEmpty) {
                  return "No Prouducts Founds"
                      .text
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .size(16)
                      .makeCentered();
                } else {
                  return GridView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 3 : 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 2 / 3),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            normalText(
                                text: currencyFormat
                                    .format(data[index]['p_price']),
                                color: redColor,
                                size: 16.0)
                          ],
                        )
                            .box
                            .padding(const EdgeInsets.all(12))
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
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
              }
            }),
      ),
    );
  }
}
