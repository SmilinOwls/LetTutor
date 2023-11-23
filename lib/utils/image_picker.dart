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
