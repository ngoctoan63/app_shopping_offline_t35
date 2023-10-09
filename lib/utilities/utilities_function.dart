import 'package:image_picker/image_picker.dart';

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

String doubleFormat(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
}

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return file.readAsBytes();
  }
  print('No image selected!');
}
