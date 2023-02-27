import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageContainer extends StatelessWidget {
  bool textScanning = false;

  XFile? imageFile;

  ImageContainer(textScanning, imageFile, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(255, 213, 241, 254),
      ),
      child: (textScanning)
          ? const CircularProgressIndicator()
          : (!textScanning && imageFile == null)
              ? Container(
                  color: Colors.amber.shade100,
                )
              : (imageFile != null)
                  ? Image.file(File(imageFile!.path))
                  : Container(),
    );
  }
}
