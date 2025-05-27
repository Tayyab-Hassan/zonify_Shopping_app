import 'package:e_commerce_app/consts/consts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isloading = false.obs;
  var isloadingwithGoogle = false.obs;

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
    final String password = '',
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

// Google Sign-In Method (Updated)
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // User canceled sign-in

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;

        // Reference to Firestore user document
        DocumentReference userDocRef =
            firestore.collection(userCollection).doc(uid);

        // Check if the user already exists in Firestore
        DocumentSnapshot userDoc = await userDocRef.get();

        if (!userDoc.exists) {
          // If user does NOT exist, store their data
          await storeUserData(
            name: googleUser.displayName ?? 'Google User',
            email: googleUser.email,
          );
        } else {
          // If user already exists, update the data with Google info
          await userDocRef.update({
            'name': googleUser.displayName ?? 'Google User',
            'email': googleUser.email,
            'imageUrl': googleUser.photoUrl ?? '',
          });
          print("User data updated with Google account details.");
        }
      }

      return userCredential;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  Future<void> signOutGoogle() async {
    try {
      await GoogleSignIn().signOut(); // Sign out from Google
      await FirebaseAuth.instance.signOut(); // Sign out from Firebase Auth
      print("User signed out successfully.");
    } catch (e) {
      print("Sign-out Error: $e");
    }
  }
}
