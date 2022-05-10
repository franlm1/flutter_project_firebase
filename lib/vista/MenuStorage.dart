 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../menu/animation_route.dart';
import 'MenuStorageGaleria.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MenuStorage());
}

class MenuStorage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MENU CONTROLADOR',
      home: Scaffold(
        body: body(),
      ),
    );
  }
}

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);
  @override
  State<body> createState() => _MenuStorage();
}

class _MenuStorage extends State<body> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference mainCollection;

  String tipo = "SingingCharacter.video";
  int selectedIndex = 0;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: button(index: 1, text: 'video'),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: button(index: 2, text: 'imagen'),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(150.0),
            child: ListView(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  Animation_route( MenuStorageGaleria(
                                      "unidad 1",tipo)))
                              .whenComplete(() => Navigator.of(context).pop());
                        
                        },
                        icon: const Icon(Icons.library_add),
                        label: const Text('UNIDAD 1'))),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        onPressed: () {
                           Navigator.push(
                                  context,
                                  Animation_route( MenuStorageGaleria(
                                      "unidad 2",tipo)))
                              .whenComplete(() => Navigator.of(context).pop());
                        },
                        icon: const Icon(Icons.library_add),
                        label: const Text('UNIDAD 2'))),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.library_add),
                        label: const Text('UNIDAD 3'))),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.library_add),
                        label: const Text('UNIDAD 4'))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  int? _selectedValueIndex = 1;
  Widget button({required String text, required int index}) {
    return InkWell(
      splashColor: Colors.cyanAccent,
      onTap: () {
        setState(() {
          _selectedValueIndex = index;
          if (index == 1) {
            tipo = "SingingCharacter.video";
          } else {
            tipo = "SingingCharacter.imagen";
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        color: index == _selectedValueIndex ? Colors.blue : Colors.white,
        child: Text(
          text,
          style: TextStyle(
            color: index == _selectedValueIndex ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }


}
