import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class PorductsDetailsSeller extends StatelessWidget {
  final dynamic data;
  const PorductsDetailsSeller({super.key, this.data});

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
          mainAxisAlignment: MainAxisAlignment.start,
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
                        aspectRatio: 16 / 9,
                        itemCount: data['p_images'].length,
                        viewportFraction: 1.0,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data['p_images'][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }),
                    10.heightBox,
                    // Title & Deatails Sections...
                    boldText(
                        text: data['p_name'], color: Colors.black, size: 18.0),
                    5.heightBox,
                    Row(
                      children: [
                        boldText(
                            text: data['p_category'],
                            color: darkFontGrey,
                            size: 16.0),
                        10.widthBox,
                        normalText(text: data['p_subcategory'], color: fontGrey)
                      ],
                    ),
                    10.heightBox,
                    //Rating...
                    VxRating(
                      isSelectable: false,
                      value: data['p_rating'],
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      size: 25,
                      maxRating: 5,
                      count: 5,
                    ),
                    10.heightBox,
                    boldText(
                        text: currencyFormat.format(data['p_price']),
                        color: darkFontGrey,
                        size: 16.0),

                    10.heightBox,

                    // Colors Section....
                    20.heightBox,
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: normalText(
                                  text: 'Color :',
                                  size: 16.0,
                                  color: darkFontGrey),
                            ),
                            Row(
                              children: List.generate(
                                  data['p_colors'].length,
                                  (index) => VxBox()
                                      .size(40, 40)
                                      .roundedFull
                                      .color(Color(data['p_colors'][index]))
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
                            50.widthBox,
                            normalText(
                                text: data['p_quantity'], color: fontGrey)
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),
                      ],
                    ).box.white.shadowSm.make(),

                    //Descripiton section...
                    10.heightBox,
                    boldText(
                        text: "Description", color: darkFontGrey, size: 16.0),
                    10.heightBox,
                    normalText(
                      text: data['p_description'],
                      color: fontGrey,
                    ),

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
