import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../menu/animation_route.dart';
import 'MenuStorageGaleria.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MenuCloud());
}

class MenuCloud extends StatefulWidget {
  // final String tematica, tipo;

  //const MenuStorageGaleria(this.tematica, this.tipo);
  @override
  State<MenuCloud> createState() => MenuCloudState();
}

class MenuCloudState extends State<MenuCloud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: null,
    );
  }
}
