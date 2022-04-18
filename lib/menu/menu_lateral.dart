import 'package:flutter/material.dart';
import 'package:tuttorial_1/add/plantilla_1.dart';

import '../add/add_register.dart';
import '../main.dart';
import 'animation_route.dart';

class MenuLateral extends StatefulWidget {
  @override
  Menu createState() => Menu();
}

class Menu extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text(
              "Alex",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black54,
              shape: BoxShape.rectangle,
            ),
          ),
          ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: const Text('Inicio'),
              onTap: () { Navigator.push(context, Animation_route(MyApp()))
              .whenComplete(() => Navigator.of(context).pop());
              }),
  
         
          ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: const Text('Registrar Tarea'),
              onTap: () {
                Navigator.push(context, Animation_route(AddRegister()))
                    .whenComplete(() => Navigator.of(context).pop());
              }),
          
        ],
      ),
    );
  }
}
