import 'package:e_commerce_app/Apps/UserSide/Controllers/auth_controller.dart';
import 'package:e_commerce_app/Apps/UserSide/Controllers/profile_controller.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Chats/messaging_screen.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Orders/orders_screen.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Profile/Components/card_details.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Profile/edit_profile_scr.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Splash_Screen/splashscreen.dart';
import 'package:e_commerce_app/Apps/UserSide/views/Wishlist/wishlist_scr.dart';
import 'package:e_commerce_app/Services/firestore_services.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/list.dart';
import 'package:e_commerce_app/widgets/bg_widget.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var controller = Get.put(ProfileController());
    return bgWidget(
      child: Scaffold(
          body: StreamBuilder(
              stream: FirestoreServices.getUser(currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  );
                } else {
                  var data = snapshot.data!.docs[0];

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        10.heightBox,

                        // Added Profile Button...
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: const Icon(
                              Icons.edit,
                              color: whiteColor,
                            ).onTap(() {
                              controller.nameController.text = data['name'];

                              Get.to(() => EditProfileScreen(data: data));
                            }),
                          ),
                        ),

                        //User details Section...
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              data['imageUrl'] == ''
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
                                  : Image.network(data['imageUrl'],
                                          width: 80, fit: BoxFit.cover)
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make(),
                              10.widthBox,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    data['name']
                                        .toString()
                                        .text
                                        .fontFamily(semibold)
                                        .white
                                        .make(),
                                    data['email'].toString().text.white.make(),
                                  ],
                                ),
                              ),
                              //LogOut Button
                              OutlinedButton(
                                  style: ButtonStyle(
                                      shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                      side: const WidgetStatePropertyAll(
                                          BorderSide(color: whiteColor))),
                                  onPressed: () async {
                                    await Get.put(AuthController())
                                        .signoutMethod(context);
                                    await Get.offAll(
                                        () => const SplashScreen());
                                  },
                                  child: logOut.text
                                      .fontFamily(semibold)
                                      .white
                                      .make())
                            ],
                          ),
                        ),

                        FutureBuilder(
                            future: FirestoreServices.getAllDoucmentsLength(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: loadingIndictor(),
                                );
                              } else {
                                var countData = snapshot.data;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    detialsCard(
                                        count: countData[0].toString(),
                                        title: 'In Your Cart',
                                        width: context.screenWidth / 3.4),
                                    detialsCard(
                                        count: countData[1].toString(),
                                        title: 'In Your Wishlist',
                                        width: context.screenWidth / 3.4),
                                    detialsCard(
                                        count: countData[2].toString(),
                                        title: 'Your Orders',
                                        width: context.screenWidth / 3.4)
                                  ],
                                );
                              }
                            }),

                        // Buttons section...
                        Container(
                          color: redColor,
                          height: context.screenHeight * 0.03,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: profileButtonsList.length,
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
                                    Get.to(() => const OrdersScreen());
                                    break;
                                  case 1:
                                    Get.to(() => const WishListScreen());
                                    break;
                                  case 2:
                                    Get.to(() => const MessagsScreen());
                                    break;
                                }
                              },
                              title: profileButtonsList[index]
                                  .text
                                  .fontFamily(bold)
                                  .color(darkFontGrey)
                                  .make(),
                              leading: Image.asset(
                                profileButtonsIconList[index],
                                width: 22,
                              ),
                            );
                          },
                        )
                            .box
                            .white
                            .roundedSM
                            .margin(const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10))
                            .shadowSm
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .make()
                            .box
                            .color(redColor)
                            .make(),

                        //Profile UI is Completed...
                      ],
                    ),
                  );
                }
              })),
    );
  }
}
