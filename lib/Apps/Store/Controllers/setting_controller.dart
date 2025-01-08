import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app/consts/consts.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class SettingController extends GetxController {
  late QueryDocumentSnapshot snapshotData;
  var nameController = TextEditingController();
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  // shope sittitng Controller
  var shopNameController = TextEditingController();
  var shopAddressController = TextEditingController();
  var shopMobileController = TextEditingController();
  var shopWebsiteController = TextEditingController();
  var shopDescriptionController = TextEditingController();

  // Observable to hold image path
  var profileImagePath = ''.obs;
  var isloading = false.obs;

  // Variable to store the image URL after uploading to Cloudinary
  var profileImageLink = '';

  // Cloudinary credentials
  final String cloudName = "dlwucnavr";
  final String apiKey = "484622225954723";
  final String apiSecret = "UNhh6mssdtHFwiU5H8iyICbzrJ4";

  // Function to select an image from the gallery
  changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (img == null) return;
      profileImagePath.value = img.path;
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // Function to upload profile image to Cloudinary and store the URL in profileImageUrl
  uploadProfileImage() async {
    if (profileImagePath.value.isEmpty) {
      print("No image selected.");
      return;
    }

    try {
      File imageFile = File(profileImagePath.value);

      String imageUrl = await _uploadToCloudinaryUnsigned(imageFile);

      // Step 3: Store the image URL in profileImageUrl variable
      profileImageLink = imageUrl;

      print("Profile picture uploaded successfully: $imageUrl");
    } catch (e) {
      print("Error uploading profile picture: $e");
    }
  }

  // Store the Url In FireBase or Set User DataCollection
  Future<void> updateStoreAccount(
      {required String name,
      required String password,
      required String imgUrl,
      context}) async {
    try {
      isloading(true);
      // Query to find the store document based on ownerId
      QuerySnapshot storeQuery = await FirebaseFirestore.instance
          .collection(vendorCollection)
          .where("ownerId", isEqualTo: currentUser!.uid)
          .get();

      // Check if a matching document exists
      if (storeQuery.docs.isNotEmpty) {
        // Get the first matching document (assuming one store per ownerId)
        DocumentSnapshot storeDoc = storeQuery.docs.first;

        // Update the fields in the document
        await storeDoc.reference.update({
          'vendorName': name,
          'password': password,
          'image': imgUrl,
        });

        VxToast.show(context, msg: "Store Account updated successfully!");
        nameController.clear();
        oldPasswordController.clear();
        newPasswordController.clear();
        isloading(false);
      } else {
        throw Exception("Store not found for the current user.");
      }
    } catch (e) {
      VxToast.show(context, msg: "Error Updating Store Account: $e");
    }
  }

  // Helper function to handle the upload to Cloudinary
  Future<String> _uploadToCloudinaryUnsigned(File imageFile) async {
    final String uploadUrl =
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload";
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    // Create a multipart request
    var request = http.MultipartRequest("POST", Uri.parse(uploadUrl));
    request.fields['api_key'] = apiKey;
    request.fields['timestamp'] = timestamp;
    request.fields['upload_preset'] = 'ys6agetl'; // Your unsigned upload preset

    // Add the image file
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));

    // Send the request
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonResponse = json.decode(responseData);

    if (response.statusCode == 200) {
      return jsonResponse['secure_url']; // URL of the uploaded image
    } else {
      throw Exception(
          "Failed to upload image to Cloudinary: ${jsonResponse['error']['message']}");
    }
  }

// shop updating Method
  updateShop(
      {context,
      shopName,
      shopAddress,
      shopMobile,
      shopWebsite,
      shopDescription}) async {
    try {
      isloading(true);
      // Query to find the store document based on ownerId
      QuerySnapshot storeQuery = await FirebaseFirestore.instance
          .collection(vendorCollection)
          .where("ownerId", isEqualTo: currentUser!.uid)
          .get();

      // Check if a matching document exists
      if (storeQuery.docs.isNotEmpty) {
        // Get the first matching document (assuming one store per ownerId)
        DocumentSnapshot storeDoc = storeQuery.docs.first;

        // Update the fields in the document
        await storeDoc.reference.set(
          {
            'storeName': shopName,
            'shop_address': shopAddress,
            'shop_mobile': shopMobile,
            'shop_website': shopWebsite,
            'shop_descrioption': shopDescription,
          },
          SetOptions(merge: true),
        );
        shopNameController.clear();
        shopAddressController.clear();
        shopMobileController.clear();
        shopWebsiteController.clear();
        shopDescriptionController.clear();
        VxToast.show(context, msg: "Store updated successfully!");
        isloading(false);
      } else {
        throw Exception("Store not found for the current user.");
      }
    } catch (e) {
      VxToast.show(context, msg: "Error Updating Store: $e");
    }
  }
}
