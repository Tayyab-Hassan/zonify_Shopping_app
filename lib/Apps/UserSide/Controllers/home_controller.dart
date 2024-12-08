import '../../../consts/consts.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0.obs;
  var username = '';
  var searchController = TextEditingController();
  // Get User-Name
  Future<void> getUsername() async {
    var querySnapshot = await firestore
        .collection(userCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // If there are documents, retrieve the first one
      var name = querySnapshot.docs.first['name'];
      username = name; // Update the username variable
    }
  }
}
