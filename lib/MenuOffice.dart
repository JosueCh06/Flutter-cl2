import 'package:cl2_seccion_01_chupica_inga_josue_daniel/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MenuOffice());
}

class MenuOffice extends StatelessWidget {
  const MenuOffice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String nombres = "";
  String pedido = "";
  double precio = 0.0;
  int cantidad = 0;
  double total = 0.0;
  double descuento = 0.0;
  double totalPagar = 0.0;
  String mensaje = "";
  bool validacion = false;
  double delivery = 0.0;
  String title = "";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSwitched = false;
  final _tfNombres = TextEditingController();
  final _tfPedido = TextEditingController();
  final _tfPrecio = TextEditingController();
  final _tfCantidad = TextEditingController();
  final _tfTotalPagar = TextEditingController();

  void _calcularTotalPagar() {
    setState(() {
      widget.validacion = false;
      if (_tfNombres.text.toString() == "" ||
          _tfPedido.text.toString() == "" ||
          _tfPrecio.text.toString() == "" ||
          _tfCantidad.text.toString() == "") {
        widget.validacion = true;
        widget.mensaje = "Ingrese los campos requeridos";
        return;
      }
      widget.cantidad = int.parse(_tfCantidad.text);
      widget.precio = double.parse(_tfPrecio.text);

      widget.total = widget.cantidad * widget.precio;
    });

    if (widget.total > 500) {
      widget.descuento = widget.total * 0.05;
    }

    if (isSwitched == true) {
      widget.delivery = 20.0;
    } else {
      widget.delivery = 0.0;
    }

    widget.totalPagar = (widget.total + widget.delivery) - widget.descuento;
    _tfTotalPagar.text = widget.totalPagar.toString();
    _showMyDialog(context, mensaje());
  }

  void initialValor(){
    _tfNombres.text = "";
    _tfPedido.text = "";
    _tfPrecio.text = "";
    _tfCantidad.text = "";
    _tfTotalPagar.text = "";
    isSwitched = false;
  }

  String mensaje(){
      return "Nombres: " + _tfNombres.text + "\n" +
             "Pedido: " + _tfPedido.text + "\n" +
             "Precio: " + _tfPrecio.text + "\n" +
             "Cantidad: " + _tfCantidad.text + "\n" +
             "Total: " + widget.total.toString() + "\n" +
             "Descuento: " + widget.descuento.toString() + "\n" +
             "Delivery: " + widget.delivery.toString() + "\n" +
             "Total a pagar: " +widget.totalPagar.toString() + "\n" +
             "Su pedido está en camino. ¡Que lo disfrute! ";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
          title: Text("Office Food " + widget.title),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                  "Bienvenido por favor complete sus datos para completar su pedido"),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                children: <Widget>[
                  TextField(
                      controller: _tfNombres,
                      maxLength: 30,
                      decoration: InputDecoration(
                        hintText: "Ingrese Nombres",
                        labelText: "Nombres",
                        errorText: _tfNombres.text.toString() == ""
                            ? widget.mensaje
                            : null,
                      )),
                  TextField(
                      controller: _tfPedido,
                      maxLength: 30,
                      decoration: InputDecoration(
                        hintText: "Ingrese un platillo",
                        labelText: "Pedido",
                        errorText: _tfPedido.text.toString() == ""
                            ? widget.mensaje
                            : null,
                      )),
                  TextField(
                      controller: _tfPrecio,
                      maxLength: 10,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: "Ingrese Precio",
                        labelText: "Precio",
                        errorText: _tfPrecio.text.toString() == ""
                            ? widget.mensaje
                            : null,
                      )),
                  TextField(
                      controller: _tfCantidad,
                      maxLength: 5,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: "Ingrese Cantidad",
                        labelText: "Cantidad",
                        errorText: _tfCantidad.text.toString() == ""
                            ? widget.mensaje
                            : null,
                      )),
                  Text("Total: " +
                      widget.total.toString() +
                      "  Descuento: " +
                      widget.descuento.toString()),
                  Text("Delivery",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                        print(isSwitched);
                      });
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),
                ],
              ),
            ),
            TextField(
                controller: _tfTotalPagar,
                readOnly: true,
                enabled: false,
                decoration: InputDecoration(
                  labelText: "Total a Pagar",
                )),
            FractionallySizedBox(
                widthFactor: 0.93, //means 80% of app width
                child: RaisedButton(
                  onPressed: _calcularTotalPagar,
                  child: Text(
                    "Calular",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.orange[300],
                )),
          ],
        ));
  }

    void _showMyDialog(BuildContext context, String mensaje){
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Descripción del Pedido"),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
                initialValor();
              },
            ),
          ],
        );
      },
    );
  }
}
