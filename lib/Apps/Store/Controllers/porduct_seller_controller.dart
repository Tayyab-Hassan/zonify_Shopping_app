import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app/Apps/Store/Controllers/store_auth_controller.dart';
import 'package:e_commerce_app/Models/category_model.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets/basic_button.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:http/http.dart' as http;

class ProductSellerController extends GetxController {
  // for Cloud Storage
  final String cloudName = "dlwucnavr";
  final String apiKey = "484622225954723";
  final String apiSecret = "UNhh6mssdtHFwiU5H8iyICbzrJ4";
  // TextFields Controller for Add Products
  var pNameController = TextEditingController();
  var pPriceController = TextEditingController();
  var pQuantityController = TextEditingController();
  var pDescriptionController = TextEditingController();

  // Create 3 List for Categories , SubCategories and Images

  var categoryList = <String>[].obs;
  var subCategoryList = <String>[].obs;
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);
  var pImagesLinks = [];
  List<Category> category = [];
  var categoryValue = ''.obs;
  var subCategoryValue = ''.obs;
  Rx<Color> selectedColor =
      Color.fromARGB(255, 0, 217, 255).obs; // Initialize with a custom Color
  var productColor = <Color>[].obs; // Ensure the list is of type Color
  var storedColors = <int>[].obs;
  var isLoading = false.obs;
  var isFeatured = 0.obs;
// Get Category
  getCateories() async {
    var data = await rootBundle.loadString("lib/Services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategroy() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  populateSubCategroy(cat) {
    subCategoryList.clear();
    var data = category.where((element) => element.name == cat).toList();
    for (var i = 0; i < data.first.subcategory.length; i++) {
      subCategoryList.add(data.first.subcategory[i]);
    }
  }

// Pick Products Colors
  void updateColor(Color color) {
    selectedColor.value = color;
  }

  void pickColor() {
    Get.dialog(
      AlertDialog(
        title: Text("Pick a color"),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: selectedColor.value,
            onColorChanged: (color) {
              updateColor(color);
            },
          ),
        ),
        actions: <Widget>[
          myButton(
              color: redColor,
              onPressed: () {
                productColor.add(selectedColor.value);
                int colorValue = selectedColor.value.value;
                if (!storedColors.contains(colorValue)) {
                  storedColors.add(colorValue);
                }
                Get.back(); // Close the dialog
              },
              title: "Select",
              textColor: white),
        ],
      ),
    );
    print("Colors: $productColor");
    print("Colors Value: $storedColors");
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img != null) {
        pImagesList[index] = File(img.path); // Add to the correct index
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    print("IMAGES: $pImagesList");
  }

  uploadImages() async {
    pImagesLinks.clear(); // Clear the list of image links

    for (var item in pImagesList) {
      if (item != null) {
        try {
          File imageFile = File(item.path);
          String imageUrl = await _uploadToCloudinaryUnsigned(imageFile);
          pImagesLinks.add(imageUrl);

          print("Image uploaded successfully: $imageUrl");
        } catch (e) {
          print("Error uploading image: $e");
        }
      }
    }

    print("All images uploaded successfully: $pImagesLinks");
  }

// Helper function to handle the upload to Cloudinary
  Future<String> _uploadToCloudinaryUnsigned(File imageFile) async {
    final String uploadUrl =
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

    // Create a multipart request
    var request = http.MultipartRequest("POST", Uri.parse(uploadUrl));
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

  // Upload the Porduct to the Firebase Store

  uploadProducts({context}) async {
    var store = firestore.collection(productsCollection).doc();
    await store.set({
      'featured_id': '',
      'is_featured': false,
      'p_category': categoryValue.value,
      'p_subcategory': subCategoryValue.value,
      'p_colors': FieldValue.arrayUnion(storedColors),
      'p_images': FieldValue.arrayUnion(pImagesLinks),
      'p_description': pDescriptionController.text,
      'p_name': pNameController.text,
      'p_price': int.tryParse(pPriceController.text),
      'p_quantity': pQuantityController.text,
      'p_rating': 5.0,
      'p_seller': Get.find<StoreHomeController>().userName,
      'p_wishlist': FieldValue.arrayUnion([]),
      'vendor_id': currentUser!.uid,
    });
    isLoading(false);
    resetFields();
    VxToast.show(context, msg: "Product Added");
  }

  // Add Product to Featured
  addFeatured(docId, context) async {
    if (isFeatured.value == 0) {
      await firestore.collection(productsCollection).doc(docId).set(
          {'featured_id': currentUser!.uid, 'is_featured': true},
          SetOptions(merge: true));
    } else {
      VxToast.show(context, msg: "You Have Already Featured Porduct");
    }
  }

  // Remove Product from Featured
  removeFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set(
        {'featured_id': "", 'is_featured': false}, SetOptions(merge: true));
  }

  // Remove Product from the firestore

  removeProduct(docId) async {
    await firestore.collection(productsCollection).doc(docId).delete();
  }

  checkForFeaturedProduct(List<DocumentSnapshot> data) {
    isFeatured.value = 0; // Reset the counter before checking

    for (var doc in data) {
      if (doc['featured_id'] != null && doc['featured_id']!.isNotEmpty) {
        isFeatured.value++;
        break; // No need to check further if a featured product is found
      }
    }
  }

  void resetFields() {
    // Reset TextControllers
    pNameController.clear();
    pPriceController.clear();
    pQuantityController.clear();
    pDescriptionController.clear();

    // Reset lists
    pImagesList.value = List<dynamic>.generate(3, (index) => null);
    pImagesLinks.clear();
    productColor.clear();
    storedColors.clear();

    // Reset selected values
    selectedColor.value = Color.fromARGB(255, 0, 217, 255);
    categoryValue.value = '';
    subCategoryValue.value = '';

    // Reset isLoading
    isLoading.value = false;
  }
}
