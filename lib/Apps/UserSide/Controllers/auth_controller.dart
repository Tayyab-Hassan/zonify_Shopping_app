import 'package:e_commerce_app/consts/consts.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  // Text Controllers for LogIn Screen
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Login Method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? 'An error occurred');
    }
    return userCredential;
  }

  // Sign Up Method
  Future<UserCredential?> signUpMethod(
      {required String email, required String password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Call storeUserData only if sign-up is successful
      if (userCredential.user != null) {
        await storeUserData(
          name: '', // Replace with actual name input if available
          password: password,
          email: email,
        );
      }
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? 'An error occurred');
    }
    return userCredential;
  }

  // Storing User Data Method
  Future<void> storeUserData({
    required String name,
    required String password,
    required String email,
  }) async {
    DocumentReference store =
        firestore.collection(userCollection).doc(currentUser!.uid);

    try {
      await store.set({
        'name': name,
        'password': password,
        'email': email,
        'imageUrl': '',
        'id': currentUser!.uid,
        'cart_count': '00',
        'wishlist_count': '00',
        'order_count': '00'
      });
      print("User data stored successfully.");
    } catch (e) {
      print("Failed to store user data: $e");
    }
  }

  // Sign Out Method
  Future<void> signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
