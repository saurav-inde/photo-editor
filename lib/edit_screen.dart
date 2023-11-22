import 'dart:io';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditScreen extends StatefulWidget {
  EditScreen({Key? key, required this.pickedImage}) : super(key: key);
  XFile? pickedImage;

  @override
  EditScreenState createState() => EditScreenState();
}
// state for the above class

class EditScreenState extends State<EditScreen> {
  CropController imgController = CropController(
    // aspectRatio: 16.0 / 9.0,
    defaultCrop: Rect.fromLTRB(0.05, 0.05, 0.95, 0.95),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: editAppBar(context),
      body: CropImage(
        controller: imgController,
        image: Image.file(File(widget.pickedImage!.path)),
      ),
    );
  }

  AppBar editAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[900],
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      actions: [
        IconButton(
          onPressed: () {
            imgController.rotateRight();
          },
          icon: const Icon(
            Icons.rotate_right,
            size: 32,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.flip,
            size: 32,
          ),
        ),
        TextButton(
          onPressed: () {
            _finished();
          },
          child: const Text(
            "CROP",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          // icon: const Icon(Icons.flip),
        ),
      ],
    );
  }

  Future<void> _finished() async {
    Image image = await imgController.croppedImage();

    Navigator.pop(context, image);
  }
}
