import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/provider.dart';

class FilePickerGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final filePickerModel = Provider.of<FilePickerModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker '),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _pickFiles(context),
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // Background color
                onPrimary: Colors.amber, // Text Color (Foreground color)
              ),
              child: Text('Pick Files'),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  final selectedFiles = filePickerModel.selectedFiles;
                  return ListView.builder(
                    itemCount: selectedFiles.length,
                    itemBuilder: (context, index) {
                      PlatformFile file = selectedFiles[index];
                      String? fileType = _getFileType(file.name);
                      String fileName = file.name;
                      int fileSize = file.size;

                      return Column(
                        children: [
                          Image.asset(
                            _getFileTypeIcon(fileType),
                            width: 140,
                            height: 100,
                          ),
                          Text('File Name: $fileName'),
                          Text(
                              'File Size: ${(fileSize / 1024).toStringAsFixed(2)} KB'),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFiles(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
      );

      if (result != null) {
        final filePickerModel =
            Provider.of<FilePickerModel>(context, listen: false);
        filePickerModel.selectedFiles.addAll(result.files);
      }
    } catch (e) {
      print('File picking error: $e');
    }
  }

  String _getFileType(String? fileName) {
    if (fileName != null) {
      final extension = fileName.split('.').last;
      return '.$extension';
    }
    return '.unknown';
  }

  String _getFileTypeIcon(String? fileType) {
    if (fileType == '.jpg' || fileType == '.jpeg' || fileType == '.png') {
      return 'assets/Jpeg.png';
    } else if (fileType == '.pdf') {
      return 'assets/pdf.png';
    } else if (fileType == '.mp3') {
      return 'assets/Mp3.png';
    } else if (fileType == '.mp4') {
      return 'assets/Mp4.png';
    } else {
      return 'assets/default.png';
    }
  }
}
