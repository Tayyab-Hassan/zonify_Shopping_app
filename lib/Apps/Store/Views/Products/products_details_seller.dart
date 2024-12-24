import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class PorductsDetailsSeller extends StatelessWidget {
  const PorductsDetailsSeller({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {},
      canPop: true,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: redColor,
          leading: IconButton(
              color: whiteColor,
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_rounded)),
          title: boldText(text: "Products Details", size: 16.0),
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Swipper Section...
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        aspectRatio: 16 / 9,
                        itemCount: 3,
                        viewportFraction: 1.0,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            imgP7,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          );
                        }),
                    10.heightBox,
                    // Title & Deatails Sections...
                    boldText(
                        text: "Product Title", color: Colors.black, size: 18.0),
                    5.heightBox,
                    Row(
                      children: [
                        boldText(
                            text: "Category", color: darkFontGrey, size: 16.0),
                        10.widthBox,
                        normalText(text: "Subcategory", color: fontGrey)
                      ],
                    ),
                    10.heightBox,
                    //Rating...
                    VxRating(
                      isSelectable: false,
                      value: 3,
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      size: 25,
                      maxRating: 5,
                      count: 5,
                    ),
                    10.heightBox,
                    boldText(text: "\$124.0", color: darkFontGrey, size: 16.0),

                    10.heightBox,

                    // Colors Section....
                    20.heightBox,
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Color:".text.color(textfieldGrey).make(),
                            ),
                            Row(
                              children: List.generate(
                                  4,
                                  (index) => VxBox()
                                      .size(40, 40)
                                      .roundedFull
                                      .color(Vx.randomColor)
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .make()),
                            )
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),

                        // Quantity Section...

                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: boldText(
                                  text: "Quantity",
                                  color: darkFontGrey,
                                  size: 16.0),
                            ),
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),
                      ],
                    ).box.white.shadowSm.make(),

                    //Descripiton section...
                    10.heightBox,
                    "Description"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    boldText(
                        text: "Product Description",
                        color: darkFontGrey,
                        size: 16.0),

                    // here Is Seller Produts Details UI is completed...
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
