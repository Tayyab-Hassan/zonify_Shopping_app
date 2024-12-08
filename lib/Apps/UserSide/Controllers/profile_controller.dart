import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app/consts/consts.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  // Profile Text Controllers
  var nameController = TextEditingController();
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();

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
  updateProfile({name, password, imgUrl}) async {
    var store = firestore.collection(userCollection).doc(currentUser!.uid);
    await store.set({'name': name, 'password': password, 'imageUrl': imgUrl},
        SetOptions(merge: true));

    isloading(false);
  }

  // when User Change the password to newPassword then change also in Authintication
  changeAuthPassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);

    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword);
    }).catchError((error) {
      print(error.toString());
    });
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
}
