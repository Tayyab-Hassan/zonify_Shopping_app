import 'package:e_commerce_app/Apps/UserSide/Controllers/products_controller.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Chats/chat_screen.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/list.dart';
import 'package:e_commerce_app/widgets/basic_button.dart';

class ItemsDetails extends StatelessWidget {
  final String? title;
  final String? docId;
  final dynamic data;
  const ItemsDetails({super.key, required this.title, this.data, this.docId});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        controller.resetValue();
      },
      canPop: true,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValue();
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_rounded)),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                )),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFev.value) {
                      controller.removeFromWishList(docId, context);
                    } else {
                      controller.addToWishList(docId, context);
                    }
                  },
                  icon: controller.isFev.value
                      ? const Icon(
                          Icons.favorite_outlined,
                          color: redColor,
                        )
                      : Image.asset(
                          icHeart,
                          width: 23,
                          color: darkFontGrey,
                        )),
            ),
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
                        itemCount: data['p_images'].length,
                        viewportFraction: 1.0,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data['p_images'][index],
                            width: double.infinity,
                            fit: BoxFit.contain,
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
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      size: 25,
                      maxRating: 5,
                      count: 5,
                    ),
                    10.heightBox,
                    "${data['p_price']}"
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
                            "${data['p_seller']}"
                                .text
                                .white
                                .fontFamily(semibold)
                                .make(),
                            5.heightBox,
                            "In House Brands"
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .size(16)
                                .make(),
                          ],
                        )),
                        // Messages Section
                        Image.asset(
                          icChat,
                          width: 23,
                          color: redColor,
                        ).onTap(() {
                          Get.to(() => const ChatScreen(),
                              arguments: [data['p_seller'], data['vendor_id']]);
                        })
                      ],
                    )
                        .box
                        .height(60)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .color(textfieldGrey)
                        .make(),

                    // Colors Section....
                    20.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Color:".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                  data['p_colors'].length,
                                  (index) => Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      VxBox()
                                          .size(40, 40)
                                          .roundedFull
                                          .color(Color(data['p_colors'][index])
                                              .withOpacity(1.0))
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 4))
                                          .make()
                                          .onTap(() {
                                        controller.changeColor(index);
                                      }),
                                      Visibility(
                                        visible: index ==
                                            controller.colorIndex.value,
                                        child: const Icon(
                                          Icons.done_outline_rounded,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          // Quantity Section...

                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity:"
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Obx(() => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.decreaseQuantity();
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.remove)),
                                      controller.quantity.value.text
                                          .size(16)
                                          .fontFamily(bold)
                                          .color(darkFontGrey)
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            controller.increaseQuantity(
                                                int.parse(data['p_quantity']));
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.add)),
                                      10.widthBox,
                                      '${data['p_quantity']}'
                                          .text
                                          .color(textfieldGrey)
                                          .make()
                                    ],
                                  )),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          // Total Section...
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Total:".text.color(textfieldGrey).make(),
                              ),
                              "${controller.totalPrice.value}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .size(16)
                                  .fontFamily(bold)
                                  .make()
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make()
                        ],
                      ).box.white.shadowSm.make(),
                    ),

                    //Descripiton section...
                    10.heightBox,
                    "Description"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    '${data['p_description']}'.text.color(darkFontGrey).make(),

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                  onPressed: () {
                    if (controller.quantity.value > 0) {
                      controller.addToCart(
                          vendorID: data['vendor_id'],
                          color: data['p_colors'][controller.colorIndex.value],
                          context: context,
                          img: data['p_images'][0],
                          quantity: controller.quantity.value,
                          sellername: data['p_seller'],
                          title: data['p_name'],
                          tPrice: controller.totalPrice.value);
                    } else {
                      VxToast.show(context, msg: "Please Add Product Quantity");
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
