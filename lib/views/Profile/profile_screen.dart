import 'package:e_commerce_app/consts/list.dart';
import 'package:e_commerce_app/views/Profile/Components/card_details.dart';
import 'package:e_commerce_app/widgets/bg_widget.dart';

import '../../consts/consts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              10.heightBox,

              // Added Profile Button...
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.edit,
                    color: whiteColor,
                  ),
                ),
              ),

              //User details Section...
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Image.asset(imgProfile2, width: 80, fit: BoxFit.cover)
                        .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make(),
                    10.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Dummy User".text.fontFamily(semibold).white.make(),
                          "dummyUser@Email.com".text.white.make(),
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
                        child: logOut.text.fontFamily(semibold).white.make())
                  ],
                ),
              ),
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  detialsCard(
                      count: '00',
                      title: 'In Your Cart',
                      width: context.screenWidth / 3.4),
                  detialsCard(
                      count: '32',
                      title: 'In Your Wishlist',
                      width: context.screenWidth / 3.4),
                  detialsCard(
                      count: '234',
                      title: 'Your Orders',
                      width: context.screenWidth / 3.4)
                ],
              ),

              // Buttons section...
              40.heightBox,
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
                  .margin(
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10))
                  .shadowSm
                  .padding(const EdgeInsets.symmetric(horizontal: 16))
                  .make()
                  .box
                  .color(redColor)
                  .make(),

              //Profile UI is Completed...
            ],
          ),
        ),
      ),
    );
  }
}
