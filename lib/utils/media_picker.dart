import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickerImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: source);
  if (pickedFile != null) {
    return await pickedFile.readAsBytes();
  }
  return null;
}

Future<File?> pickerVideo(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickVideo(source: source);
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}
