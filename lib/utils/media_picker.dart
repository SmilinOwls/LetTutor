import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> pickerImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: source);
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}

Future<File?> pickerVideo(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickVideo(
    source: source,
    maxDuration: const Duration(seconds: 90),
  );
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}
