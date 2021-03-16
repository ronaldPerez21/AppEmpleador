import 'package:busqueda/screens/modals/FiltrosServicios.dart';
import 'package:busqueda/screens/modals/PerfilEmpleado.dart';
import 'package:flutter/material.dart';

import 'screens/Index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
    //Se indica que el tema tiene un brillo luminoso/claro
    brightness: Brightness.light,
    primarySwatch: Colors.cyan,
  ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => ListaTrabajos(),
        "/busquedaDatos": (BuildContext context) => DatosBusqueda(),
        "/recuperarDatos": (BuildContext context) => RecuperarDatos(),
        // "/solicitud": (BuildContext context) => Solicitud(),
      }
    );
  }
}
