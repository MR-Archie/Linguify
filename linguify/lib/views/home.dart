import 'package:flutter/material.dart';
import 'package:linguify/widgets/image_container.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "";

  void picker(BuildContext context,
      {VoidCallback? onCameraTap, VoidCallback? onGalleryTap}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.25,
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                InkWell(
                  onTap: onCameraTap,
                  child: Card(
                    elevation: 3,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      child: const Text(
                        "Choose from Camera",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: onGalleryTap,
                  child: Card(
                    elevation: 3,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      child: const Text(
                        "Choose from Gallery",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          textScanning = true;
          imageFile = pickedImage;
        });
      }
    } catch (e) {
      setState(() {
        textScanning = false;
        imageFile = null;
        scannedText = "Error occured while scanning";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Linguify"),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: Column(children: [
          ImageContainer(textScanning, imageFile),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () => picker(
              context,
              onCameraTap: () => getImage(ImageSource.camera),
              onGalleryTap: () => getImage(ImageSource.gallery),
            ),
            style: ElevatedButton.styleFrom(
              // ignore: deprecated_member_use
              primary: Colors.amber.shade50,
            ),
            child: const Text(
              "Choose image",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ),
    );
  }
}
