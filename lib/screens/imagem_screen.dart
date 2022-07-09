import 'dart:html';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'chamado_screen.dart';

import 'package:filesystem_picker/filesystem_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class ImagemScreen extends StatefulWidget {
  static const String id = '/imagem';

  const ImagemScreen({Key? key}) : super(key: key);

  @override
  State<ImagemScreen> createState() => _ImagemScreenState();
}


class _ImagemScreenState extends State<ImagemScreen> {
  static const String id = '/imagem';

  late String directory;
  List file = [];


// variable to hold image to be displayed

  late Uint8List uploadedImage;







  //-------------------------------------
  @override
  void initState() {
    super.initState();

    _startFilePicker();
  }

  late List<FileSystemEntity> _fileList;
  //-------------------------------------
  Future<void> _loadFiles() async {
    Directory rootPath = await getTemporaryDirectory();

    String? path = await FilesystemPicker.open(title: 'Save to folder',
      context: context,
      rootDirectory: rootPath,
      fsType: FilesystemType.folder,
      pickText: 'Save file to this folder',
      folderIconColor: Colors.teal,
    );
  }

  //method to load image and update `uploadedImage`
  _startFilePicker() async {
    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files?.length == 1) {
        final file = files![0];
        FileReader reader =  FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            uploadedImage = reader.result as Uint8List;
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            String option1Text = "Some Error occured while reading the file";
          });
        });
        reader.readAsArrayBuffer(file);
      }
    });
  }

  //-------------------------------------
  Future<void> _showDialog(BuildContext context, str1, str2) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Aviso !!"),
          content: new Text(str1 + " " + str2),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //-------------------------------------
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //navigatorKey: navigatorKey,
      title: 'List of Files',
      home: Scaffold(


        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: file.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(file[index].path);
                    }),
              )
            ],
          ),
       ),
      ),
    );
  }
}