import 'package:cl2_seccion_01_chupica_inga_josue_daniel/MenuOffice.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Office Food'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: [
            Container(
              child: Image.asset(
                'assets/delivery.png',
                width: 250,
                height: 250,
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              margin: EdgeInsets.all(10),
            ),
            Center(
              child: Text("Registra tu pedido, y disfruta del contenido"),
            ),
            FractionallySizedBox(
                widthFactor: 0.92, //means 80% of app width
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuOffice()),
                    );
                  },
                  child: Text(
                    "Registra tu pedido ¡Ya!",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.orange[300],
                )),
          ],
        ));
  }
}
