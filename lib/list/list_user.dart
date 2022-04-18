import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:tuttorial_1/menu/menu_lateral.dart';

class ListUser extends StatefulWidget {
  @override
  ListUserState createState() => ListUserState();
}

class ListUserState extends State<ListUser> {
  @override
  void initState() {
    super.initState();
  }

  Widget appBarTitle = const Text(
    "Search user",
    style: TextStyle(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        actions:  [

        ],
      ),
      drawer:MenuLateral() ,
      body: ListView(
        children: [

        ],
      )
    );
  }
}
