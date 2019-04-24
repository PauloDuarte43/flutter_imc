import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _alturaControl = new TextEditingController();
  final TextEditingController _pesoControl = new TextEditingController();
  double resultado = 0.0;
  String diagnostico = "";

  void _calcularIMC() {
    setState(() {
      if (_alturaControl.text.isNotEmpty && _pesoControl.text.isNotEmpty) {
        double altura = double.parse(_alturaControl.text);
        double peso = double.parse(_pesoControl.text);

        if (altura > 0 && peso > 0) {
          debugPrint("$peso");
          debugPrint("$altura");
          double tmp = pow(altura, 2);
          debugPrint("$tmp");
          resultado = peso / tmp;
          debugPrint("$resultado");

          if (resultado < 17) {
            diagnostico = "Muito abaixo do peso";
          } else if (resultado <= 18.49) {
            diagnostico = "Abaixo do peso";
          } else if (resultado <= 24.99) {
            diagnostico = "Peso normal";
          } else if (resultado <= 29.99) {
            diagnostico = "Acima do peso";
          } else if (resultado <= 34.99) {
            diagnostico = "Obesidade I";
          } else if (resultado <= 39.99) {
            diagnostico = "Obesidade II (severa)";
          } else if (resultado >= 40.0) {
            diagnostico = "Obesidade III (mórbida)";
          } else {
            diagnostico = "TODO";
          }
        }
      } else {
        resultado = 0.0;
        diagnostico = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("IMC"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[
            Image.asset(
              "assets/imc-logo.png",
              height: 75.0,
              width: 70.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                color: Colors.grey.shade300,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _alturaControl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Altura (m)",
                            hintText: '0.00',
                            icon: Icon(Icons.insert_chart)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _pesoControl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Peso",
                            hintText: '0.00',
                            icon: Icon(Icons.line_weight)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        onPressed: _calcularIMC,
                        color: Colors.pink,
                        child: Text("Calcular"),
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  resultado > 0 ? "IMC: ${resultado.toStringAsFixed(2)}" : "",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 19.9),
                ),
                Text(
                  "$diagnostico",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 19.9),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
