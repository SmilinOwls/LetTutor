import 'package:file_picker/file_picker.dart';

Future<PlatformFile?> pickFile() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'doc', 'docx'],
  );

  final PlatformFile? file = result?.files.single;
  return file;
}
