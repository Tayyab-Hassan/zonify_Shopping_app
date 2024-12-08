import 'package:e_commerce_app/Apps/UserSide/Controllers/products_controller.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Category/categories_details.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/list.dart';
import 'package:e_commerce_app/widgets/bg_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).white.make(),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: categoriesImagesList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 3 / 4),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(
                          categoriesImagesList[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  10.heightBox,
                  categoriesTitleList[index]
                      .text
                      .fontFamily(semibold)
                      .color(darkFontGrey)
                      .align(TextAlign.center)
                      .make(),
                  10.heightBox
                ],
              )
                  .box
                  .white
                  .roundedSM
                  .clip(Clip.antiAlias)
                  .shadowSm
                  .make()
                  .onTap(() {
                controller.getSubCategories(categoriesTitleList[index]);
                Get.to(
                    () => CategoriesDetails(title: categoriesTitleList[index]));
              });
            }),
      ),
    ));
  }
}
