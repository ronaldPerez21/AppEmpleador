
import 'package:busqueda/screens/modals/operaciones.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'modals/PerfilEmpleado.dart';

class ListaServicios extends StatefulWidget{
  Future<List<dynamic>> futuro;
  ListaServicios(this.futuro);
  ListaServiciosState createState() => ListaServiciosState();

}

class ListaServiciosState extends State<ListaServicios>{
  @override
  Widget build(BuildContext context) {
    // ParamListaServicios arguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: widget.futuro,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return _createItem(snapshot.data);
          }else
            return Center(
              child: CircularProgressIndicator()
              );
        }
      )
    );
  }

  _createItem(lista) {
      return RefreshIndicator(
        child: ListView.builder(
          itemCount: lista == null ? 0: lista.length,
          itemBuilder: (context, index) {
            return GestureDetector( 
              onTap: (){
                Navigator.of(context).pushNamed("/recuperarDatos", 
                                                arguments: MisDatosParam(id: lista[index]['id'].toString() ));

              },
              child: Card(
              color: Colors.white60,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              margin: EdgeInsets.all(8),
              child: Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:  NetworkImage("https://fotografias.lasexta.com/clipping/cmsimages02/2019/11/14/66C024AF-E20B-49A5-8BC3-A21DD22B96E6/58.jpg",),
                          
                            
                          )
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:  10,left: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Operacion.textosEstilosDif("Nombre: " + lista[index]['nombre'],
                        estilo: TextStyle(fontSize: 14, fontWeight: FontWeight.bold )),

                        Operacion.textosEstilosDif("Dirección: " + lista[index]['direccion']),

                        Operacion.textosEstilosDif("Teléfono: " + lista[index]['telefono'].toString()),

                        Operacion.textosEstilosDif("Turno: " )
                        ]
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          );
        }
      ),
      onRefresh: () => widget.futuro,
    );
  }

}