import 'package:firebase_storage/firebase_storage.dart';

class LoadImagen {
  final String selectedValue;
  final String tipo;
  late ListResult result;
  FirebaseStorage storage = FirebaseStorage.instance;
  
  LoadImagen(this.selectedValue, this.tipo);//--

  Future<List<Map<String, dynamic>>> loadImages() async {
    List<Map<String, dynamic>> files = [];
  
    if (tipo == 'SingingCharacter.video') {
      
      result = await storage.ref().child(selectedValue).child("Video").list();
    } else {
      result = await storage.ref().child(selectedValue).child('Imagen').list();
    }

    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        "description":
            fileMeta.customMetadata?['description'] ?? 'No description',
      });
    });

    return files;
  }

}
