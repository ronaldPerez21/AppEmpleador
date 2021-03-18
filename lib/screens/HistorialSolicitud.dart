

import 'package:busqueda/api/Peticiones.dart';
import 'package:busqueda/screens/detalleHistorial.dart';
import 'package:busqueda/screens/modals/operaciones.dart';
import 'package:flutter/material.dart';

class HistorialSolicitudes extends StatefulWidget{

  HistorialSolicitudesState createState() => HistorialSolicitudesState();

}

class HistorialSolicitudesState extends State<HistorialSolicitudes>{

var lista;


  void initState(){
    super.initState();
    refrescar();
  }


Future<Null> refrescar() async {
  var auxLista = await TraerDatos.getHistorialSolicitudes();
  setState((){
    lista = auxLista;
  });
  return null;
}

Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Historial"),),
      body: _createItem(this.lista)
    );
  }

  _createItem(lista) {
      return RefreshIndicator(
        child: ListView.builder(
          itemCount: lista == null ? 0: lista.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed("/detalleSolicitud", 
                arguments: DetalleHistorialParam(
                    descripcion: lista[index]['descripcion'], 
                    latitud: lista[index]['latitud'], 
                    longitud: lista[index]['longitud'], 
                    costo: lista[index]['costo'], 
                    fecha: lista[index]['fecha'], 
                    estado: lista[index]['estado'], 
                    nombre: lista[index]['nombre']
                  )
                );
              },
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.white60,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      margin: EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Operacion.textosEstilosDif("Descripción: " + lista[index]['descripcion'],
                        estilo: TextStyle(fontSize: 14, fontWeight: FontWeight.bold )),

                        Operacion.textosEstilosDif("Fecha: " + lista[index]['fecha']),

                        Operacion.textosEstilosDif("Estado: " + lista[index]['estado'].toString()),
                        ]
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
        }
        ),
        onRefresh: refrescar,
      );
  }


}