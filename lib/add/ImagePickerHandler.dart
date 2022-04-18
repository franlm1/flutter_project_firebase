import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class ImagePickerHandler {
  ImagePickerListener _listener;
  static Future<PickedFile>? imageFile;
  final ImagePicker _picker = ImagePicker();
  static PickedFile? galleryFile;

  ImagePickerHandler(this._listener);

 
  pickImageFromGalleryVideo() async {
     XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
    _listener.userImageVideo(File(image!.path));
   
  }
   pickImageFromGalleryDoc() async {
     XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    _listener.userImageDoc(File(image!.path));
   
  }

}

abstract class ImagePickerListener {
  userImageVideo(File _image);
  userImageDoc(File _image);
}
