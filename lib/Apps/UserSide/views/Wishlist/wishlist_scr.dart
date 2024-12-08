// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app/Services/firestore_services.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/loading_indicator.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        leading: BackButton(
          color: whiteColor,
        ),
        title: "My Wishlist".text.fontFamily(semibold).color(whiteColor).make(),
      ),
      backgroundColor: whiteColor,
      body: StreamBuilder(
          stream: FirestoreServices.getAllWishList(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndictor(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return 'Your WishList is Empty'
                  .text
                  .color(darkFontGrey)
                  .makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                              "${data[index]["p_images"][0]}",
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                            title: "${data[index]['p_name']}"
                                .text
                                .fontFamily(semibold)
                                .size(16)
                                .make(),
                            subtitle: "${data[index]['p_price']}"
                                .numCurrency
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make(),
                            trailing: IconButton(
                                onPressed: () async {
                                  await firestore
                                      .collection(productsCollection)
                                      .doc(data[index].id)
                                      .set({
                                    'p_wishlist': FieldValue.arrayRemove(
                                      [currentUser!.uid],
                                    )
                                  }, SetOptions(merge: true));
                                },
                                icon: Image.asset(
                                  icTrash,
                                  width: 22,
                                )),
                          );
                        }),
                  ),
                ],
              );
            }
          }),
    );
  }
}
