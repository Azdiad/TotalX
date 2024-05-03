import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String images = "";

  Future<void> uploadImage(ImageSource source) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file == null) return;
  }

  Future<void> addUser(BuildContext context) async {
    if (images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(" Select to Upload Image"),
      ));
      return;
    }
    final String name = nameController.text;
    final int? age = int.tryParse(ageController.text);
    if (age != null) {
      nameController.text = name;
      ageController.text = age.toString();
      Navigator.pop(context);
    }
  }
}
