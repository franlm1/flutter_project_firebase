import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/vista/SubirArchivos.dart';
import 'package:video_player/video_player.dart';
import '../menu/animation_route.dart';
import '../servicios/LoadImages.dart';

class GaleriaStorage extends StatefulWidget {
  final String tematica;
  final String titulo;
  final String tipo;

  const GaleriaStorage(this.tematica, this.titulo,
      this.tipo); //ENVIAMOS LOS DATOS CON EL CONSTRUCTOR
  @override
  State<GaleriaStorage> createState() => _GaleriaStorageState();
}

class _GaleriaStorageState extends State<GaleriaStorage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  late String nombre = "";
  late VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    if (widget.tipo == 'SingingCharacter.video') {
      //WIDGET.TIPO LO QUE HACE ES DARLE VALOR AL TIPO CREADO
      //EN EL CONSTRUCTOR
      nombre = 'Videos';
    } else {
      nombre = 'Archivos';
    }
    super.initState();
  }

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
                Navigator.push(context, Animation_route(Storage()))
                    .whenComplete(() => Navigator.of(context).pop());
              }),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.tematica.toUpperCase(),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                nombre.toUpperCase(),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: LoadImagen(widget.tematica, widget.tipo)
                    .loadImages(), //PASAMOS AL CONSTRUCTOR LOADIMAGES LOS ARTRIBUTOS
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> image =
                            snapshot.data![index];
                        controller =
                            VideoPlayerController.network(image['url']);
                        _initializeVideoPlayerFuture = controller.initialize();
                        controller.setLooping(true);

                        print(image['url']);
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
                              onPressed: () => _delete(image['path']),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _delete(String ref) async {
    await storage.ref(ref).delete();
    // Rebuild the UI
    setState(() {});
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
}
