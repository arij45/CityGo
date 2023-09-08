import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

/*pickProfileImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print("No Images Selected");
}

 */

PlatformFile? file;
pickImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'png', 'jpg'],
  );

  print('FilePickerResult: $result');

  if (result != null && result.files.isNotEmpty) {
    file = result.files.first;
    print(file);
    return file?.path;
  }
  print("No Images Selected");
  return null;
}





