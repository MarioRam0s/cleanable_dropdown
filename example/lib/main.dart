import 'package:clearable_dropdown/clearable_dropdown.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isError = false;

  FocusNode focusSelect = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Color.fromARGB(255, 21, 83, 156),
        title: RichText(
          text: TextSpan(
            style: TextStyle(fontWeight: FontWeight.bold),
            children: [
              TextSpan(text: '< Lord / Dev > \n\n'),
              TextSpan(text: 'Flutter Demo Clearable Dropdown'),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            ClearableDropdown(
              listItems: [
                CatalogObject(id: 0, name: 'Manzana'),
                CatalogObject(id: 1, name: 'Naranja'),
              ],
              focus: focusSelect,
              errorText:
                  isError == true
                      ? 'Debe seleccionar al menos un registro'
                      : null,
            ),
            SizedBox(height: 40),
            ClearableDropdown(
              listItems: [
                CatalogObject(id: 0, name: 'Sunflower'),
                CatalogObject(id: 1, name: 'Baby'),
                CatalogObject(id: 2, name: 'Lady in red'),
                CatalogObject(id: 3, name: 'Me rehuso'),
                CatalogObject(id: 4, name: 'Callaita'),
                CatalogObject(id: 5, name: 'I wanna be yours'),
                CatalogObject(id: 6, name: 'Desire'),
                CatalogObject(id: 7, name: 'Firestone'),
              ],
              menuHeight: 500,
              label: 'Seleccione una canción - Sin boton de eliminar selección',
            ),
            SizedBox(height: 40),
            ClearableDropdown(
              listItems: [
                CatalogObject(id: 0, name: 'Ingeniería de sistemas'),
                CatalogObject(id: 1, name: 'Ingeniería en computacion'),
                CatalogObject(id: 2, name: 'Ingeniería Industrial'),
                CatalogObject(id: 3, name: 'Ingeniería Química'),
                CatalogObject(id: 4, name: 'Ingeniería Aeroespacial'),
              ],
              label: 'Seleccione una carrera',
              valueInitial: 'Ingeniería de sistemas',
              enable: false,
              onDeleteSelection: () {},
            ),
            SizedBox(height: 40),
            ClearableDropdown(
              listItems: [
                CatalogObject(id: 0, name: 'Futbol'),
                CatalogObject(id: 1, name: 'Tenis'),
                CatalogObject(id: 2, name: 'Padel'),
                CatalogObject(id: 3, name: 'Ajedrez'),
                CatalogObject(id: 4, name: 'Básquetbol'),
                CatalogObject(id: 5, name: 'Natación'),
              ],
              label: 'Seleccione un deporte',
              helperText: 'Seleccione un deporte para continuar',
              leadingIcon: Icon(Icons.sports),
              menuStyle: MenuStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.amberAccent),
                shadowColor: WidgetStatePropertyAll(Colors.pink),
                elevation: WidgetStatePropertyAll(30),
                visualDensity: VisualDensity.compact,
                side: WidgetStatePropertyAll(
                  BorderSide(color: Colors.green, width: 10),
                ),
              ),
              onDeleteSelection: () {},
            ),
            SizedBox(height: 40),
            ClearableDropdown(
              listItems: [
                CatalogObject(id: 0, name: 'Marvel Rivals'),
                CatalogObject(id: 1, name: 'League of legends'),
                CatalogObject(id: 2, name: 'Minecraft'),
                CatalogObject(id: 3, name: 'Elden ring'),
                CatalogObject(id: 4, name: 'God of war Ragnarok'),
                CatalogObject(id: 5, name: 'Stronghold'),
              ],
              label: 'Seleccione un juego',
              menuHeight: 100,
              errorText: 'Seleccione al menos un registro',
              onDeleteSelection: () {},
              deleteIcon: Icon(Icons.delete),
            ),
            SizedBox(height: 40),
            ClearableDropdown(
              listItems: [
                CatalogObject(id: 0, name: 'Pokemon'),
                CatalogObject(id: 1, name: 'Tokyo Ghoul'),
                CatalogObject(id: 2, name: 'Kiss x Sis'),
                CatalogObject(id: 3, name: 'Akame ga kill'),
                CatalogObject(id: 4, name: 'Slam Dunk'),
                CatalogObject(id: 5, name: 'Shingeki no Kyojin'),
              ],
              onSelected: (p0) {
                final snackBar = SnackBar(
                  content: Text('Seleccionó el registro #$p0'),
                  duration: Duration(milliseconds: 400),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              label: 'Seleccione un anime',
              onDeleteSelection: () {
                final snackBar = SnackBar(
                  content: Text('Selección eliminada'),
                  duration: Duration(milliseconds: 400),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            SizedBox(height: 40),
            ClearableDropdown(
              listItems: [
                CatalogObject(id: 0, name: 'Perro'),
                CatalogObject(id: 1, name: 'Cerdo'),
                CatalogObject(id: 2, name: 'Vaca'),
                CatalogObject(id: 3, name: 'Gato'),
                CatalogObject(id: 4, name: 'Raton'),
                CatalogObject(id: 5, name: 'Pez'),
              ],
              hint: 'Seleccione un animal',
              inputDecorationTheme: InputDecorationTheme(
                fillColor: Colors.amber,
                iconColor: Colors.red,
                filled: true,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 10,
                    style: BorderStyle.solid,
                  ),
                ),
                errorStyle: TextStyle(
                  backgroundColor: Colors.purple,
                  color: Colors.white,
                  height: 5,
                ),
              ),
              errorText: 'Error personalizado',
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isError = true;
          focusSelect.requestFocus();
          setState(() {});
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
