import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:tuttorial_1/cards/card_video.dart';


import '../main.dart';
import '../menu/animation_route.dart';
import '../menu/menu_lateral.dart';
import '../cards/card_doc.dart';
import '../cards/card_video.dart';

void main() => runApp(AddRegister());

class AddRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SUBIR ARCHIVOS',
        theme: ThemeData(
          //Se indica que el tema tiene un brillo luminoso/claro
          brightness: Brightness.light,
          primarySwatch: Colors.pink,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.pink,
        ),
        home: HomePage(title: 'REGISTRAR TAREfirebase flutter '),
        routes: <String, WidgetBuilder>{});
  }
}

class HomePage extends StatelessWidget {
  final String title;
  HomePage({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xffffffff),
                ),
                onTap: () {
                  Navigator.push(context, Animation_route(MyApp()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
        body: UserForm(),
        drawer: MenuLateral());
  }
}

class UserForm extends StatefulWidget {
  @override
  UserFormState createState() {
    return UserFormState();
  }
}

// TODO: MENU PRINCIPAL
class UserFormState extends State<UserForm> {
  //ATRIBUTOS
  FirebaseStorage storage = FirebaseStorage.instance;
  List<String> spinnerCurso = ['Curso 1', 'Curso 2', 'Curso 3', 'Curso 4'];
  List<String> spinnerModulo = ['Modulo 1', 'Modulo 2', 'Modulo 3', 'Modulo 4'];
  late String dropdownValueCurso, dropdownValueModulo;
  var descripcionVideo = TextEditingController();
  var descripcionDoc = TextEditingController();

  @override
  void initState() {
    dropdownValueCurso = spinnerCurso[0];
    dropdownValueModulo = spinnerModulo[0];
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
            child: CardVideos(),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
            child: registrar(),
          ),
        ],
      ),
    );
  }
  //WIDGET BOTON REGISTRAR

  Widget registrar() {
    return TextButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(color: Colors.red)))),
      onPressed: () {
        Future<List<Map<String, dynamic>>> _loadImages() async {
          List<Map<String, dynamic>> files = [];

          final ListResult result = await storage.ref().list();
          final List<Reference> allFiles = result.items;

          await Future.forEach<Reference>(allFiles, (file) async {
            final String fileUrl = await file.getDownloadURL();
            final FullMetadata fileMeta = await file.getMetadata();
            files.add({
              "url": fileUrl,
              "path": file.fullPath,
              "uploaded_by":
                  fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
              "description":
                  fileMeta.customMetadata?['description'] ?? 'No description'
            });
          });

          return files;
        }
      },
      child: const Text('Registrar tarea '),
    );
  }
}
