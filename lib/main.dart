import 'dart:io';
import 'package:filepick/view/homepage.dart';
import 'package:filepick/viewmodel/provider.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => FilePickerModel(),
        child: FilePickerGridView(),
      ),
    );
  }
}
