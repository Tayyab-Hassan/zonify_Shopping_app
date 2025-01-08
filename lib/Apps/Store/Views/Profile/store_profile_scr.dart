import 'package:e_commerce_app/Apps/Store/Controllers/setting_controller.dart';
import 'package:e_commerce_app/Apps/Store/Controllers/store_auth_controller.dart';
import 'package:e_commerce_app/Apps/Store/Views/Auth/login_to_store.dart';
import 'package:e_commerce_app/Apps/Store/Views/Chats/seller_messeges_screen.dart';
import 'package:e_commerce_app/Apps/Store/Views/Profile/store_editporfile.dart';
import 'package:e_commerce_app/Apps/Store/Views/shop/shop_sitting.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Home/home.dart';
import 'package:e_commerce_app/Services/store_services.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/list.dart';
import 'package:e_commerce_app/widgets/bg_widget.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';
import 'package:e_commerce_app/widgets/text_style.dart';

class StoreProfileScreen extends StatelessWidget {
  const StoreProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SettingController());
    var c = Get.find<StoreHomeController>();
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
                  Get.to(() => EditPorfileStore(
                        username: controller.snapshotData['vendorName'],
                      ));
                },
                icon: Image.asset(
                  icEditProfile,
                  width: 25,
                  color: white,
                )),
          ],
        ),
        body: StreamBuilder(
            stream: StoreServices.getProfile(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: loadingIndictor());
              } else {
                controller.snapshotData = snapshot.data!.docs[0];

                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.snapshotData['image'] == ''
                                ? CircleAvatar(
                                    backgroundColor: redColor,
                                    child: Image.asset(
                                      icProfile,
                                      width: 25,
                                      fit: BoxFit.cover,
                                      color: whiteColor,
                                    ),
                                  )
                                    .box
                                    .size(50, 50)
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make()
                                : Image.network(
                                        controller.snapshotData['image'],
                                        fit: BoxFit.cover)
                                    .box
                                    .size(50, 50)
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make(),
                            10.widthBox,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  normalText(
                                      text: controller
                                                  .snapshotData['storeName'] ==
                                              ''
                                          ? "Edit Shop Name"
                                          : '${controller.snapshotData['storeName']}',
                                      size: 16.0),
                                  normalText(
                                      text:
                                          '${controller.snapshotData['email']}',
                                      size: 16.0),
                                ],
                              ),
                            ),
                            OutlinedButton(
                                style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    side: const WidgetStatePropertyAll(
                                        BorderSide(color: whiteColor))),
                                onPressed: () async {
                                  await c.clearStoreLoginState();
                                  Get.offAll(() => LoginToStore());
                                },
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
                          return const Divider(
                            color: lightGrey,
                          );
                        },
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(() => ShopSitting());
                                  break;
                                case 1:
                                  Get.to(() => ShopMessagsScreen());
                                  break;
                                case 2:
                                  Get.offAll(() => Home());
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
                            ),
                          );
                        },
                      )
                          .box
                          .white
                          .roundedSM
                          .margin(const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15))
                          .shadowSm
                          .padding(const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20))
                          .make()
                          .box
                          .make(),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
