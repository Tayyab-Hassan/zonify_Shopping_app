// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app/Apps/Store/Controllers/porduct_seller_controller.dart';
import 'package:e_commerce_app/Apps/Store/Views/Products/Components/porduct_dropdown.dart';
import 'package:e_commerce_app/Apps/Store/Views/Products/Components/product_images.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/basic_button.dart';
import 'package:e_commerce_app/widgets/bg_widget.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductSellerController>();
    return bgWidget(
      child: Obx(
        () => Scaffold(
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
              TextButton(
                  onPressed: () async {
                    controller.isLoading(true);
                    await controller.uploadImages();
                    await controller.uploadProducts(context: context);

                    Get.back();
                  },
                  child: controller.isLoading.value
                      ? loadingIndictor(color: whiteColor)
                      : boldText(text: 'Add +'))
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
                      controller: controller.pNameController),
                  10.heightBox,
                  customTextField(
                      title: "Price",
                      hint: "Enter product price",
                      isPass: false,
                      controller: controller.pPriceController),
                  10.heightBox,
                  customTextField(
                      title: "Quantity",
                      hint: 'Enter avalible Porducts quantities',
                      isPass: false,
                      controller: controller.pQuantityController),
                  10.heightBox,
                  customTextField(
                      title: description,
                      hint: "Please Discribe your product",
                      isPass: false,
                      isDes: true,
                      controller: controller.pDescriptionController),
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
                    children: [
                      Expanded(
                        child: porductDropDown(
                            hint: "Category",
                            list: controller.categoryList,
                            controller: controller,
                            dropvalue: controller.categoryValue),
                      ),
                      10.widthBox,
                      Expanded(
                        child: porductDropDown(
                            hint: "Subcategory",
                            list: controller.subCategoryList,
                            dropvalue: controller.subCategoryValue,
                            controller: controller),
                      ),
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
                      return controller.pImagesList[index] != null
                          ? Image.file(
                              controller.pImagesList[index],
                              width: 100,
                              height: 120,
                            ).onTap(() {
                              controller.pickImage(index, context);
                            })
                          : productImages().onTap(() {
                              controller.pickImage(index, context);
                            });
                    }),
                  ),
                  10.heightBox,
                  Divider(
                    color: redColor,
                  ),
                  boldText(
                      text: "Choose Porduct Colors",
                      color: redColor,
                      size: 16.0),
                  5.heightBox,
                  myButton(
                      title: "Pick Colors",
                      color: redColor,
                      textColor: white,
                      onPressed: () {
                        controller.pickColor();
                      }),
                  10.heightBox,
                  Wrap(
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
                  )
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
      ),
    );
  }
}
