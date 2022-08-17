import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagepicker = ImagePicker();
  XFile? _file = await imagepicker.pickImage(source: source);
  if (_file != null) {
    return _file.readAsBytes();
  }
  print("No image selected");
}
