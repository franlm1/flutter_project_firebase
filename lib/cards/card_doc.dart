import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../add/ImagePickerHandler.dart';

class CardDocs extends StatefulWidget {
  @override
  CardDoc createState() {
    return CardDoc();
  }
}

class CardDoc extends State<CardDocs> with ImagePickerListener {
  late ImagePickerHandler imagePicker;
  static File? croppedFileDoc;
  late VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;
  //late Future<void> _initializeDoc;
  @override
  void initState() {
    super.initState();
    imagePicker = ImagePickerHandler(this);
    croppedFileDoc = null;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // TODO: MENU PRINCIPAL
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        
        // CARD DOCUMENTO
        Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: InkWell(
              child: Container(
            height: 100,
            width: 200,
            child: showImageDoc(),
          )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
                child: const Text("Galeria Documento"),
                color: Colors.white10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                onPressed: () {
                  imagePicker.pickImageFromGalleryDoc();
                }),
          ],
        ),
      ],
    );
  }

 
  // WIDGET DOCUMENTO 
  Widget showImageDoc() {
    if (croppedFileDoc != null) {
      return Image(image: FileImage(croppedFileDoc!));
    } else {
      return const Image(image: AssetImage('assets/english.png'));
    }
  }
  
  //METODOS ABSTRACTOR
  
  @override
  userImageDoc(File _image) {
    croppedFileDoc = _image;
    setState(() {});
  }

  @override
  userImageVideo(File _image) {
    // TODO: implement userImageVideo
    throw UnimplementedError();
  }
   

}
