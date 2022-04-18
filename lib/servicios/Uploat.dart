import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';


class UploatImagen {
  final String tematica;
  final String titulo;
  final String descripcion;
  final String tipo;

  FirebaseStorage storage = FirebaseStorage.instance;

  UploatImagen(this.tematica, this.titulo, this.descripcion, this.tipo);

  Future<void> upload() async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      if (tipo.trim() == "SingingCharacter.video") {
       
        pickedImage = await picker.pickVideo(
          source: ImageSource.gallery,
        );
      } else {
        pickedImage =
            await picker.pickImage(source: ImageSource.gallery, maxWidth: 1920);
      }

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        // Uploading the selected image with some custom meta data
        if (tipo.trim() == "SingingCharacter.video") {
          await storage
              .ref()
              .child(tematica)
              .child('Video')
              .child(titulo)
              .putFile(
                  imageFile,
                  SettableMetadata(customMetadata: {
                    'uploaded_by': titulo,
                    'description': descripcion
                  }));
        } else {
          await storage
              .ref()
              .child(tematica)
              .child('Imagen')
              .child(titulo)
              .putFile(
                  imageFile,
                  SettableMetadata(customMetadata: {
                    'uploaded_by': titulo,
                    'description': descripcion
                  }));
        }
        // Refresh the UI

      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }
}
