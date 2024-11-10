import '../../consts/consts.dart';
import '../../consts/list.dart';
import '../../widgets/home_button.dart';
import 'components/featuers_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchAnythig,
                  hintStyle: TextStyle(color: textfieldGrey)),
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
                                ],
                              )).toList(),
                    ),
                  ),
                  //Featuers Products
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: redColor,
                    ),
                    child: Stack(children: [
                      Image.asset(
                        icSplashBg,
                        height: 310,
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
                            child: Row(
                                children: List.generate(
                                    6,
                                    (index) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              imgP1,
                                              width: 140,
                                              height: 170,
                                              fit: BoxFit.cover,
                                            ),
                                            10.heightBox,
                                            "HP Laptop 6 Gen"
                                                .text
                                                .fontFamily(semibold)
                                                .color(darkFontGrey)
                                                .make(),
                                            10.heightBox,
                                            "\$400"
                                                .text
                                                .fontFamily(semibold)
                                                .color(redColor)
                                                .size(16)
                                                .make()
                                          ],
                                        )
                                            .box
                                            .roundedSM
                                            .shadowMd
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 6))
                                            .padding(const EdgeInsets.all(8))
                                            .white
                                            .make())),
                          )
                        ],
                      ),
                    ]),
                  ),

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
                  GridView.builder(
                      shrinkWrap: true,
                      itemCount: 6,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              mainAxisExtent: 300,
                              crossAxisSpacing: 8),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              imgP5,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            const Spacer(),
                            "Hand Bag"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "\$100"
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .size(16)
                                .make()
                          ],
                        )
                            .box
                            .padding(const EdgeInsets.all(12))
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .white
                            .roundedSM
                            .shadowSm
                            .make();
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
