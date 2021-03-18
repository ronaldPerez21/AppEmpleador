

import 'package:busqueda/api/Peticiones.dart';
import 'package:busqueda/screens/modals/Mapa.dart';
import 'package:busqueda/screens/modals/operaciones.dart';
import 'package:flutter/material.dart';

class DetalleHistorial extends StatefulWidget{

  DetalleHistorialState createState() => DetalleHistorialState();

}

class DetalleHistorialState extends State<DetalleHistorial>{

String estado = "";

Widget build(BuildContext context) {

  DetalleHistorialParam arguments = ModalRoute.of(context).settings.arguments;
  _definirEstado(context);
    return Scaffold(
      appBar: AppBar(title: Text(arguments.nombre),),
      body: _createItem(context)
    );
  }

  _createItem(context) {
    DetalleHistorialParam arguments = ModalRoute.of(context).settings.arguments;
    return ListView(
      
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [ 

                   Operacion.textStyleTitleSubtitle(Icon(Icons.comment), "Descripción: ", arguments.descripcion, 18),

                    if (arguments.costo == null)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Operacion.textStyleTitleSubtitle(Icon(Icons.monetization_on), " Costo: ", "No definido", 18)
                      )
                    else 
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Operacion.textStyleTitleSubtitle(Icon(Icons.monetization_on), " Costo: ", arguments.costo, 18),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Operacion.textStyleTitleSubtitle(Icon(Icons.calendar_today), " Fecha: ", arguments.fecha, 18),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Operacion.textStyleTitleSubtitle(Icon(Icons.comment), " Estado: ", "", 18),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 2.0),
                      child: Container(
                        height: 50,
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 30,
                              child: Center(child: Text(this.estado,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                              )),
                              decoration: BoxDecoration(
                                color: Color(0xff5DBFA6),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            Spacer(),

                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, right: 5),
                              child: GestureDetector(
                                onTap: (){
                                  Mapa mapa = Mapa(-17.814581, -63.1560853);
                                  mapa.initState();
                                  return mapa.alertDialog(context);
                                },
                                child: Column(
                                  children: [
                                    Text("Ver ubicación"),
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.red
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),


                  ]
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _definirEstado(context){
    DetalleHistorialParam arguments = ModalRoute.of(context).settings.arguments;
    
    setState(() {
      switch (arguments.estado.trim()) {
        case 'a': estado = "Aceptado"; break;
        case 'p': estado = "Pendiente"; break;
        case 'r': estado = "Rechazado"; break;
        default:
      }
    });
    

  }

}

class DetalleHistorialParam{
  String descripcion;
  String latitud;
  String longitud;
  String costo;
  String fecha;
  String estado;
  String nombre;

  DetalleHistorialParam({
    this.descripcion,
    this.latitud,
    this.longitud,
    this.costo,
    this.fecha,
    this.estado,
    this.nombre,
  });

}