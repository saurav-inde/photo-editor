import 'dart:developer';

import 'package:editor/edit_screen.dart';
import 'package:editor/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late final XFile? pickedImage;

  final overlays = ['heart', 'square', 'circle', 'rectangle'];
  int selectedOverlay = -1;
  int finalSelectedOverlay = -2;
  late Image finalImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                padding: EdgeInsets.all(8),
                width: double.infinity,
                // color: Colors.yellow,
                child: Column(
                  children: [
                    const Text("Upload Image"),
                    const SizedBox(
                      height: 8,
                    ),
                    // Button for choosing the image from the device
                    FilledButton(
                      style: buttonStyle,
                      onPressed: () async {
                        final pickedImage = await pickImageFromGallery();
                        if (pickedImage != null) {
                          log("imagePicked");
                          // ignore: use_build_context_synchronously
                          final editedImage = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditScreen(pickedImage: pickedImage)));
                          showImage(context, editedImage);
                        }
                      },
                      child: const Text('Choose from Device'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              if (finalSelectedOverlay != -2)
                Center(
                  child: Container(
                    height: 300,
                    width: 300,
                    child: Stack(
                      children: [
                        FittedBox(fit: BoxFit.scaleDown, child: finalImage),
                        if (finalSelectedOverlay == 0)
                          FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Image.asset('assets/images/h.png')),
                        // Image.asset('assets/images/h.png'),
                        if (finalSelectedOverlay == 1)
                          Image.asset('assets/images/s.png'),
                        if (finalSelectedOverlay == 2)
                          Image.asset('assets/images/c.png'),
                        if (finalSelectedOverlay == 3)
                          Image.asset('assets/images/r.png'),
                      ],
                    ),
                  ),
                ),
            ],
          )),
    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
      title: Text(
        'Add Image/Icon',
        style: GoogleFonts.gideonRoman(fontSize: 22, color: Colors.grey[800]),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          appBarLeadingAction(context);
        },
        icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey[800]),
      ),
    );
  }

  void appBarLeadingAction(BuildContext context) {
    SystemNavigator.pop();
  }

  Future<XFile?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    return pickedImage;
  }

  void showImage(BuildContext context, Image image) async {
    await showDialog<bool>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(6.0),
          titlePadding: const EdgeInsets.all(8.0),
          // title: const Text('Cropped image'),
          children: [
            Column(
              children: [
                Text('Uploaded Image'),
                const SizedBox(height: 5),
                Container(
                  height: 300,
                  child: Stack(children: [
                    FittedBox(
                      child: image,
                      fit: BoxFit.fill,
                    ),
                    if (selectedOverlay == 0)
                      FittedBox(
                          fit: BoxFit.fill,
                          child: Image.asset('assets/images/h.png')),
                    if (selectedOverlay == 1)
                      FittedBox(
                          fit: BoxFit.fill,
                          child: Image.asset('assets/images/s.png')),
                    if (selectedOverlay == 2)
                      FittedBox(
                          fit: BoxFit.fill,
                          child: Image.asset('assets/images/c.png')),
                    if (selectedOverlay == 3)
                      FittedBox(
                          fit: BoxFit.fill,
                          child: Image.asset('assets/images/r.png')),
                  ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                        onPressed: () => setState(() {
                              selectedOverlay = -1;
                            }),
                        child: Text("Original")),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedOverlay = 0;
                        });
                      },
                      child: Image.asset(
                        'assets/images/heart.png',
                        height: 48,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedOverlay = 1;
                        });
                      },
                      child: Image.asset(
                        'assets/images/square.png',
                        height: 48,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedOverlay = 2;
                        });
                      },
                      child: Image.asset(
                        'assets/images/circle.png',
                        height: 48,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedOverlay = 3;
                        });
                      },
                      child: Image.asset(
                        'assets/images/rectangle.png',
                        height: 48,
                      ),
                    ),
                  ],
                ),
                // ClipRect(child: PhotoBorder.basic(amount: 80, child: image)),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      finalImage = image;
                      finalSelectedOverlay = selectedOverlay;
                    });
                    Navigator.pop(context, true);
                  },
                  child: const Text('Use this Image'),
                  // finalSelectedOverlay selectedOverlay,

                  style: buttonStyle.copyWith(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(8))),
                ),
              ],
            )
            // Text('relative: ${imgController.crop}'),
          ],
        );
      },
    );
  }
}
