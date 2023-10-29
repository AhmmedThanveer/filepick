import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class FilePickerModel extends ChangeNotifier {
  List<PlatformFile> selectedFiles = [];

  void addSelectedFile(PlatformFile file) {
    selectedFiles.add(file);
    notifyListeners();
  }

  void removeSelectedFile(int index) {
    selectedFiles.removeAt(index);
    notifyListeners();
  }
}
