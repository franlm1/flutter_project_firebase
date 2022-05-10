


import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tuttorial_1/servicios/CustomDropdownButton2.dart';
import 'package:tuttorial_1/vista/MenuControlador.dart';
import '../menu/animation_route.dart';
import '../menu/menu_lateral.dart';
import '../servicios/CustomDropdownButton2.dart';
import '../servicios/Uploat.dart';
import 'GalleriaStorage.dart';


class Storage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SUBIR STORAGE',
        theme: ThemeData(
          //Se indica que el tema tiene un brillo luminoso/claro
          brightness: Brightness.light,
          primarySwatch: Colors.pink,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.pink,
        ),
        home: HomePage(title: 'SUBIR ARCHIVOS'),
        routes: const <String, WidgetBuilder>{});
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
                  Navigator.push(context, Animation_route(MenuControlador()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
    body: Body(),
    drawer: MenuLateral());
  }
}

enum SingingCharacter { video, pdf }

class Body extends StatefulWidget {
  @override
  Principal createState() {
    return Principal();
  }
}

// TODO: CLASS PRINCIPAL
class Principal extends State<Body> {

  String? selectedValue;
  List<String> items = ['unidad 1', 'unidad 2', 'unidad 3', 'unidad 4'];
  SingingCharacter? _character = SingingCharacter.video;
  FirebaseStorage storage = FirebaseStorage.instance;
  final titulo = TextEditingController();
  final descripcion = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  //TODO MENU PRINCIPAL
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(100),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomDropdownButton2(
                    hint: 'Unidad',
                    value: selectedValue,
                    dropdownItems: items,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: titulo,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      hintText: 'Titulo',
                      hintStyle: const TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: descripcion,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    hintText: 'Descripcion',
                    hintStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Video'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.video,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Pdf'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.pdf,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              /*BOTON*/ Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                      onPressed: () {
                  
                        if (titulo.text.isEmpty) {
                        } else {
                          setState((){});
                            UploatImagen(selectedValue!,titulo.text, descripcion.text,
                                  _character.toString()).upload();
                        
                        Navigator.push(context, Animation_route(GaleriaStorage(selectedValue!,titulo.text,_character.toString())))
                      .whenComplete(() => Navigator.of(context).pop());

                          titulo.clear();
                          descripcion.clear();
                         
                        }
                      },
                      icon: const Icon(Icons.library_add),
                      label: const Text('Gallery'))),
            ],
          )),
    );
  }
}
