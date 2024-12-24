import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/bg_widget.dart';
import 'package:e_commerce_app/widgets/custom_textfield.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class ShopSitting extends StatelessWidget {
  const ShopSitting({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: white,
          ),
          title: boldText(
            text: "Shop Setting",
            size: 16.0,
          ),
          actions: [
            TextButton(onPressed: () {}, child: boldText(text: 'Save'))
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: white,
                  child:
                      Image.asset(icShopSetting, width: 45, fit: BoxFit.cover),
                )
                    .box
                    .size(80, 80)
                    .border(color: redColor)
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make(),
                10.heightBox,
                customTextField(
                  title: shopName,
                  hint: shopnameHint,
                  isPass: false,
                ),
                10.heightBox,
                customTextField(
                    title: shopAddress, hint: shopAddressHint, isPass: false),
                10.heightBox,
                customTextField(
                    title: shopeMobile, hint: shopMobileHint, isPass: false),
                10.heightBox,
                customTextField(
                    title: shopWebSite, hint: shopWebsiteHint, isPass: false),
                10.heightBox,
                customTextField(
                    title: description,
                    hint: shopDescHint,
                    isPass: false,
                    isDes: true),
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
