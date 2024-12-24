import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/widgets/basic_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class ProductSellerController extends GetxController {
  Rx<Color> selectedColor =
      Color.fromARGB(255, 0, 217, 255).obs; // Initialize with a custom Color
  var productColor = <Color>[].obs; // Ensure the list is of type Color
  var storedColors = <int>[].obs;

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
}
