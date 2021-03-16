
import 'package:busqueda/ListaServicios.dart';
import 'package:busqueda/PerfilEmpleado.dart';
import 'package:busqueda/Operaciones.dart';
import 'package:busqueda/Peticiones.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusquedaPorServicio extends StatefulWidget{
  String query;
  BusquedaPorServicio(this.query);
  BusquedaPorServicioState createState() => BusquedaPorServicioState();

}

class BusquedaPorServicioState extends State<BusquedaPorServicio>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListaServicios(TraerDatos.getEmpleadosPorServicio(widget.query))
    );
  }
}