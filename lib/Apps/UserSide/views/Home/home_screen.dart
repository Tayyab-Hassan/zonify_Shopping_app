import 'package:e_commerce_app/Apps/UserSide/Controllers/home_controller.dart';
import 'package:e_commerce_app/Apps/UserSide/Controllers/products_controller.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Category/items_details.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Home/components/featuers_button.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Home/search_scr.dart';
import 'package:e_commerce_app/Services/firestore_services.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/list.dart';
import 'package:e_commerce_app/widgets/home_button.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    var homeController = Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              controller: homeController.searchController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.search).onTap(() {
                    if (homeController
                        .searchController.text.isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                            title:
                                homeController.searchController.text.toString(),
                          ));
                    }
                  }),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchAnythig,
                  hintStyle: const TextStyle(color: textfieldGrey)),
            ),
          ),
          //Swippers Brands
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: sliderList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Image.asset(
                          sliderList[index],
                          fit: BoxFit.fill,
                        )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make());
                      }),
                  10.heightBox,
                  // Deals Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      2,
                      (index) => homeButtons(
                        height: context.screenHeight * 0.15,
                        width: context.screenWidth / 2.5,
                        icon: index == 0 ? icTodaysDeal : icFlashDeal,
                        tile: index == 0 ? todaydeal : flashsale,
                      ),
                    ),
                  ),
                  //2nd Swipper
                  10.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Image.asset(
                          secondSliderList[index],
                          fit: BoxFit.fill,
                        )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make());
                      }),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        3,
                        (index) => homeButtons(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 3.5,
                              icon: index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              tile: index == 0
                                  ? topCategory
                                  : index == 1
                                      ? brand
                                      : topSellers,
                            )),
                  ),
                  //Featured Categories
                  10.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategory.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make()),
                  20.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  featuerButton(
                                      title: featuerTitles1[index],
                                      icon: featuerImages1[index]),
                                  10.heightBox,
                                  featuerButton(
                                      title: featuerTitles2[index],
                                      icon: featuerImages2[index]),
                                  20.heightBox,
                                ],
                              )).toList(),
                    ),
                  ),
                  //Featuers Products

                  Stack(children: [
                    Image.asset(
                      icSplashBg,
                      height: 290,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProducts.text.white
                            .size(18)
                            .fontFamily(bold)
                            .make(),
                        10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: StreamBuilder(
                              stream: FirestoreServices.getFeaturedProducts(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: loadingIndictor(),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "No Featured Products"
                                      .text
                                      .color(whiteColor)
                                      .fontFamily(semibold)
                                      .makeCentered();
                                } else {
                                  var featuredData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                      featuredData.length,
                                      (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            featuredData[index]['p_images'][0],
                                            width: 160,
                                            height: 190,
                                            fit: BoxFit.cover,
                                          ),
                                          10.heightBox,
                                          "${featuredData[index]["p_name"]}"
                                              .text
                                              .fontFamily(semibold)
                                              .color(darkFontGrey)
                                              .make(),
                                          10.heightBox,
                                          normalText(
                                              text: currencyFormat.format(
                                                  featuredData[index]
                                                      ["p_price"]),
                                              color: redColor,
                                              size: 16.0)
                                        ],
                                      )
                                          .box
                                          .roundedSM
                                          .shadowMd
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 6))
                                          .padding(const EdgeInsets.all(8))
                                          .white
                                          .make()
                                          .onTap(() {
                                        controller
                                            .checkIsFev(featuredData[index]);
                                        Get.to(
                                          () => ItemsDetails(
                                            title: featuredData[index]
                                                ['p_name'],
                                            data: featuredData[index],
                                            docId: featuredData[index].id,
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                }
                              }),
                        )
                      ],
                    ),
                  ])
                      .box
                      .color(redColor)
                      .width(double.infinity)
                      .padding(const EdgeInsets.all(12))
                      .roundedSM
                      .make(),

                  //3rd Swipper
                  20.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Image.asset(
                          secondSliderList[index],
                          fit: BoxFit.fill,
                        )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make());
                      }),
                  20.heightBox,
                  //All Products...
                  StreamBuilder(
                      stream: FirestoreServices.getAllProducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: loadingIndictor());
                        } else {
                          var allproductsData = snapshot.data!.docs;
                          return GridView.builder(
                              shrinkWrap: true,
                              itemCount: allproductsData.length,
                              physics: const NeverScrollableScrollPhysics(),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image.network(
                                          allproductsData[index]['p_images'][0],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    10.heightBox,
                                    "${allproductsData[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    normalText(
                                        text: currencyFormat.format(
                                            allproductsData[index]['p_price']),
                                        color: redColor,
                                        size: 16.0)
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
                                  controller.checkIsFev(allproductsData[index]);
                                  Get.to(
                                    () => ItemsDetails(
                                      title: allproductsData[index]['p_name'],
                                      data: allproductsData[index],
                                      docId: allproductsData[index].id,
                                    ),
                                  );
                                });
                              });
                        }
                      })
                  //Home Screen UI Completed...
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
