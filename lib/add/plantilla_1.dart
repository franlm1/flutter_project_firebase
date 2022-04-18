// main.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../menu/animation_route.dart';
import '../menu/menu_lateral.dart';
import 'galeria_storage.dart';

class ListStorages extends StatefulWidget {
  @override
  ListStorage createState() {
    return ListStorage();
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
                  Navigator.push(context, Animation_route(MyApps()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
        body: Body(),
        drawer: MenuLateral());
  }
}

class Body extends StatefulWidget {
 

  @override
  ListStorage createState() {
    return ListStorage();
  }
}

class ListStorage extends State<ListStorages> {
  var nombre = "tomas";

  @override
  Future<void> initState() async {
    /* WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp();*/
    super.initState();
  }

  // TODO: MENU PRINCIPAL
  // Retriew the uploaded images
  // This function is called when the app launches for the first time or when an image is uploaded or deleted
  
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
