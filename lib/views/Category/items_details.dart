import '../../consts/consts.dart';
import '../../consts/list.dart';
import '../../widgets/basic_button.dart';

class ItemsDetails extends StatelessWidget {
  final String? title;
  const ItemsDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_outline_outlined,
              )),
        ],
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
                      itemBuilder: (context, index) {
                        return Image.asset(
                          imgFc5,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      }),
                  10.heightBox,
                  // Title & Deatails Sections...
                  title!.text
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .size(16)
                      .make(),
                  10.heightBox,
                  //Rating...
                  VxRating(
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    size: 25,
                    stepInt: true,
                    count: 5,
                  ),
                  10.heightBox,
                  "\$30,000"
                      .text
                      .color(redColor)
                      .fontFamily(bold)
                      .size(18)
                      .make(),

                  10.heightBox,
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Seller".text.white.fontFamily(semibold).make(),
                          5.heightBox,
                          "In House Brands"
                              .text
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                        ],
                      )),
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.message_rounded),
                      )
                    ],
                  )
                      .box
                      .height(60)
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .color(textfieldGrey)
                      .make(),

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
                              3,
                              (index) => VxBox()
                                  .size(40, 40)
                                  .roundedFull
                                  .color(Vx.randomPrimaryColor)
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .make(),
                            ),
                          )
                        ],
                      ).box.padding(const EdgeInsets.all(8)).make(),

                      // Quantity Section...

                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Quantity:".text.color(textfieldGrey).make(),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.remove)),
                              "0"
                                  .text
                                  .size(16)
                                  .fontFamily(bold)
                                  .color(darkFontGrey)
                                  .make(),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add)),
                              10.widthBox,
                              '(0 avalible)'.text.color(textfieldGrey).make()
                            ],
                          ),
                        ],
                      ).box.padding(const EdgeInsets.all(8)).make(),
                      // Total Section...
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: "Total:".text.color(textfieldGrey).make(),
                          ),
                          "\$0.00"
                              .text
                              .color(redColor)
                              .size(16)
                              .fontFamily(bold)
                              .make()
                        ],
                      ).box.padding(const EdgeInsets.all(8)).make()
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
                  'This is the Dummy Item and Dummy Description here...'
                      .text
                      .color(darkFontGrey)
                      .make(),

                  // Buttons Section
                  10.heightBox,
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                        itemsDetailsButtonList.length,
                        (index) => ListTile(
                              title: itemsDetailsButtonList[index]
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              trailing: const Icon(Icons.arrow_forward),
                            )),
                  ),

                  // Products you may Like Section
                  20.heightBox,
                  prouductYouMayLike.text
                      .fontFamily(bold)
                      .size(16)
                      .color(darkFontGrey)
                      .make(),
                  10.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                            6,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      imgP1,
                                      width: 130,
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
                  ),

                  // here Is  Details UI is completed...
                ],
              ),
            ),
          )),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: myButton(
                color: redColor,
                textColor: whiteColor,
                title: 'Add To Cart',
                onPressed: () {}),
          )
        ],
      ),
    );
  }
}
