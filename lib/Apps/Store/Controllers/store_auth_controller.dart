// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app/Apps/Store/Views/Home/storehome.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreHomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUserName();
    fetchDashboardData();
  }

  var vendorName = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;
  var navIndex = 0.obs;
  var userName = '';

  // Dashboard metrics
  var productCount = 0.obs;
  var averageRating = 0.0.obs;
  var totalSales = 0.obs;
  var orderCount = 0.obs;

  // Get Store UserName
  getUserName() async {
    var n = await firestore
        .collection(vendorCollection)
        .where('ownerId', isEqualTo: currentUser!.uid)
        .get();

    if (n.docs.isNotEmpty) {
      // If there are documents, retrieve the first one
      var name = n.docs.first['vendorName'];
      userName = name; // Update the username variable
    }
    print("MY store: $userName");
  }

  // Method to check if the store already exists and create one if not
  Future<void> checkAndCreateStore({required BuildContext context}) async {
    isLoading(true); // Show loading indicator
    try {
      // Get current user
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        VxToast.show(context, msg: "User is not logged in.");
        return;
      }

      // Check if the store already exists for the current user
      final existingStore = await FirebaseFirestore.instance
          .collection(vendorCollection)
          .where('ownerId', isEqualTo: currentUser.uid)
          .get();

      if (existingStore.docs.isNotEmpty) {
        // Store already exists
        VxToast.show(context, msg: "You already have a store Please logIn.");
      } else {
        // Create a new store
        await createStore(context: context, currentUser: currentUser);
        VxToast.show(context, msg: "Store Account created Sucssfully");
        Get.offAll(() => StoreHome());
      }
    } catch (e) {
      VxToast.show(context, msg: "An error occurred: $e");
    } finally {
      isLoading(false); // Stop loading indicator
    }
  }

  // Method to create a store
  Future<void> createStore({
    required BuildContext context,
    required User currentUser,
  }) async {
    try {
      // Generate unique store ID
      String storeId =
          FirebaseFirestore.instance.collection(vendorCollection).doc().id;

      // Set default store data
      Map<String, dynamic> storeData = {
        'vendorName': vendorName.text.trim(),
        'storeId': storeId,
        'ownerId': currentUser.uid, // Firebase Authentication UID
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'storeName': '', // Default empty
        'image': '', // Default empty
      };

      // Add to Firestore
      await FirebaseFirestore.instance
          .collection(vendorCollection)
          .doc(storeId)
          .set(storeData);
      // Save login state (optional)
      await saveStoreLoginState();

      VxToast.show(context, msg: "Store created successfully!");
    } catch (e) {
      VxToast.show(context, msg: "Error Creating Store: $e");
    }
  }

  // logIn To the Store
  Future<bool> loginToStore({required BuildContext context}) async {
    try {
      // Query Firestore for the vendor's email and password
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection(vendorCollection)
          .where('email', isEqualTo: emailController.text.trim())
          .where('password', isEqualTo: passwordController.text.trim())
          .get();

      if (result.docs.isNotEmpty) {
        // Vendor exists
        final vendorData = result.docs.first.data() as Map<String, dynamic>;
        print('Vendor Logged In: ${vendorData['storeId']}');

        // Save login state (optional)
        await saveStoreLoginState();

        return true;
      } else {
        // No vendor found
        VxToast.show(context, msg: "Invalid email or password");
        return false;
      }
    } catch (e) {
      print('Error logging in to store: $e');
      VxToast.show(context, msg: "Error: $e");
      return false;
    }
  }

// Save StoreSate in local storage
  Future<void> saveStoreLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isStoreLoggedIn', true);
  }

// Remove the Store CurrentSate from local storage
  Future<void> clearStoreLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isStoreLoggedIn', false);
  }

  // Fetch dashboard metrics
  fetchDashboardData() async {
    try {
      isLoading(true);
      String vendorId = currentUser!.uid;

      // Fetch product count
      var productsQuery = await FirebaseFirestore.instance
          .collection(productsCollection)
          .where('vendor_id', isEqualTo: vendorId)
          .get();
      productCount.value = productsQuery.docs.length;

      // Fetch average rating
      if (productsQuery.docs.isNotEmpty) {
        double totalRating = productsQuery.docs
            .map((doc) => doc['p_rating'] as double)
            .reduce((a, b) => a + b);
        averageRating.value = totalRating / productsQuery.docs.length;
      }

      // Fetch total sales
      var ordersQuery = await FirebaseFirestore.instance
          .collection(ordersCollection)
          .where('orders.vendor_id', arrayContains: vendorId)
          .get();

      int totalSalesCount = 0;
      for (var order in ordersQuery.docs) {
        List<dynamic> items = order['orders'];
        for (var item in items) {
          if (item['vendor_id'] == vendorId) {
            totalSalesCount += item['quantity'] as int;
          }
        }
      }
      totalSales.value = totalSalesCount;

      // Fetch order count
      var vendorOrdersQuery = await FirebaseFirestore.instance
          .collection(ordersCollection)
          .where('vendors', arrayContains: vendorId)
          .get();
      orderCount.value = vendorOrdersQuery.docs.length;
    } catch (e) {
      print("Error fetching dashboard data: $e");
    } finally {
      isLoading(false);
    }
  }
}
