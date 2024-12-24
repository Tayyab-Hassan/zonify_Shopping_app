import 'package:e_commerce_app/Apps/Store/Controllers/porduct_seller_controller.dart';
import 'package:e_commerce_app/Apps/Store/Views/Products/Components/porduct_dropdown.dart';
import 'package:e_commerce_app/Apps/Store/Views/Products/Components/product_images.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/basic_button.dart';
import 'package:e_commerce_app/widgets/bg_widget.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductSellerController());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: white,
            onPressed: () {
              controller.productColor.clear();
              controller.storedColors.clear();
              Get.back();
            },
          ),
          title: boldText(
            text: "Add Product",
            size: 16.0,
          ),
          actions: [
            TextButton(onPressed: () {}, child: boldText(text: 'Add +'))
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                  title: "Product Name",
                  hint: "Enter your Porduct name",
                  isPass: false,
                ),
                10.heightBox,
                customTextField(
                    title: "Price", hint: "Enter product price", isPass: false),
                10.heightBox,
                customTextField(
                    title: "Quantity",
                    hint: 'Enter avalible Porducts quantities',
                    isPass: false),
                10.heightBox,
                customTextField(
                    title: description,
                    hint: "Please Discribe your product",
                    isPass: false,
                    isDes: true),
                10.heightBox,
                Divider(
                  color: redColor,
                ),
                boldText(
                    text: "Choose Porduct Category",
                    color: redColor,
                    size: 16.0),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    porductDropDown(hint: "Category"),
                    10.widthBox,
                    porductDropDown(hint: "Subcategory"),
                  ],
                ),
                10.heightBox,
                Divider(
                  color: redColor,
                ),
                boldText(text: "Porduct Images", color: redColor, size: 16.0),
                3.heightBox,
                normalText(
                  text: "NOTE: First image will be your display image",
                  color: redColor,
                ),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(3, (index) {
                    return productImages();
                  }),
                ),
                10.heightBox,
                Divider(
                  color: redColor,
                ),
                boldText(
                    text: "Choose Porduct Colors", color: redColor, size: 16.0),
                5.heightBox,
                myButton(
                    title: "Pick Colors",
                    color: redColor,
                    textColor: white,
                    onPressed: () {
                      controller.pickColor();
                    }),
                10.heightBox,
                Obx(() {
                  return Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: controller.productColor.map((color) {
                      return Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                      );
                    }).toList(),
                  );
                })
              ],
            )
                .box
                .white
                .shadowSm
                .padding(const EdgeInsets.all(16))
                .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
                .roundedSM
                .make(),
          ),
        ),
      ),
    );
  }
}
