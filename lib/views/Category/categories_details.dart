import '../../consts/consts.dart';
import '../../widgets/bg_widget.dart';
import 'items_details.dart';

class CategoriesDetails extends StatelessWidget {
  final String? title;
  const CategoriesDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      appBar: AppBar(
        title: title!.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    6,
                    (index) => "Baby"
                        .text
                        .size(12)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .makeCentered()
                        .box
                        .white
                        .roundedSM
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .size(120, 60)
                        .make()),
              ),
            ),
            20.heightBox,
            // Items Categories
            Expanded(
                child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 250,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            imgP5,
                            width: 200,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
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
                          .outerShadowSm
                          .make()
                          .onTap(() {
                        Get.to(() => const ItemsDetails(title: "Dummy items"));
                      });
                    }))
          ],
        ),
      ),
    ));
  }
}
