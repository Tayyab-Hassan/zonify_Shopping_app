import 'package:e_commerce_app/Apps/Store/Views/Chats/seller_messeges_screen.dart';
import 'package:e_commerce_app/Apps/Store/Views/Profile/edit_porfile.dart';
import 'package:e_commerce_app/Apps/Store/Views/shop/shop_sitting.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/list.dart';
import 'package:e_commerce_app/widgets/bg_widget.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class StoreProfileScreen extends StatelessWidget {
  const StoreProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: boldText(
            text: setting,
            size: 16.0,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => EditPorfileStore());
                },
                icon: Image.asset(
                  icEditProfile,
                  width: 25,
                  color: white,
                )),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: whiteColor,
                      child: Image.asset(
                        icProfile,
                        width: 25,
                        fit: BoxFit.cover,
                        color: redColor,
                      ),
                    ).box.size(50, 50).roundedFull.clip(Clip.antiAlias).make(),
                    10.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          normalText(text: credits, size: 16.0),
                          normalText(text: emailhint, size: 16.0),
                        ],
                      ),
                    ),
                    OutlinedButton(
                        style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            side: const WidgetStatePropertyAll(
                                BorderSide(color: whiteColor))),
                        onPressed: () {},
                        child: normalText(
                          text: logOut,
                        ))
                  ],
                ),
              ),
              30.heightBox,
              ListView.separated(
                shrinkWrap: true,
                itemCount: profileTitleList.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return Card(
                    color: white,
                    elevation: 3,
                    child: ListTile(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.to(() => ShopSitting());
                            break;
                          case 1:
                            Get.to(() => ShopMessagsScreen());
                            break;
                          default:
                        }
                      },
                      title: profileTitleList[index]
                          .text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .make(),
                      leading: Image.asset(
                        profileIconList[index],
                        width: 22,
                        color: redColor,
                      ),
                    ),
                  );
                },
              )
                  .box
                  .white
                  .roundedSM
                  .margin(
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15))
                  .shadowSm
                  .padding(
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20))
                  .make()
                  .box
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
