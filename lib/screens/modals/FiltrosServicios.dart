import 'package:busqueda/api/Peticiones.dart';
import 'package:busqueda/screens/ListaServicios.dart';
import 'package:flutter/material.dart';


class DatosBusqueda extends StatefulWidget {
  DatosBusqueda({Key key}) : super(key: key);

  @override
  _DatosBusquedaState createState() => _DatosBusquedaState();
}

class _DatosBusquedaState extends State<DatosBusqueda>{
  
  
  
  @override
  Widget build(BuildContext context) {
    ParametroBusqueda arguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text("Lista de Trabajos"), backgroundColor: Color(0xff5DBFA6)),
      body: ListaServicios(TraerDatos.buscarUsuarioM(arguments.servicio, arguments.ubicacion, arguments.turno))
    );
  }

}

class ParametroBusqueda{
  String servicio;
  String ubicacion;
  String turno;

  ParametroBusqueda({this.servicio, this.ubicacion, this.turno});
}