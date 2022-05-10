import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/servicios/loadImages.dart';
import 'package:tuttorial_1/vista/MenuStorage.dart';
import 'package:video_player/video_player.dart';

import '../menu/animation_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //runApp(MenuStorage());
}

class MenuStorageGaleria extends StatefulWidget {
  final String tematica, tipo;

  const MenuStorageGaleria(this.tematica, this.tipo);
  @override
  State<MenuStorageGaleria> createState() => MenuStorageGaleriaState();
}

class MenuStorageGaleriaState extends State<MenuStorageGaleria> {
  late CollectionReference mainCollection;
  late VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galeria'),
        actions: [
          InkWell(
              child: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xffffffff),
              ),
              onTap: () {
                Navigator.push(context, Animation_route(MenuStorage()))
                    .whenComplete(() => Navigator.of(context).pop());
              }),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(200),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(5.0), child: Text("")),
            Expanded(
              child: FutureBuilder(
                future: LoadImagen(widget.tematica, widget.tipo).loadImages(),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final Map<String, dynamic> image = snapshot.data![index];
                      controller = VideoPlayerController.network(image['url']);
                      _initializeVideoPlayerFuture = controller.initialize();
                      controller.setLooping(true);
                      //print(image['url']);
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          dense: false,
                          //leading: Image.network(image['url']),
                          leading: image['url'].contains('Video')
                              ? showImageVideo()
                              : Image.network(image['url']),
                          title: Text(image['uploaded_by']),
                          subtitle: Text(image['description']),
                          trailing: IconButton(
                            onPressed: () {
                              
                              _addItem(widget.tipo.substring(17), image['uploaded_by'],
                                  image['description'], image['path']);
                          
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showImageVideo() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 80,
        height: 100,
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _addItem(
      String tipo, String title, String description, String url) async {
    mainCollection = firestore.collection('Modulos');
    DocumentReference documentReferencer = mainCollection.doc('m1_2').collection('fff').doc("Ddd");

    Map<String, dynamic> data = <String, dynamic>{
      "url": url,
      "description": description,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));
  }
}
