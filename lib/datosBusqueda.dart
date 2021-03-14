import 'package:busqueda/PerfilEmpleado.dart';
import 'package:busqueda/traerDatos.dart';
import 'package:flutter/material.dart';

import 'operaciones.dart';


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
      body: FutureBuilder<List> ( 
        future: TraerDatos.buscarUsuarioM(arguments.servicio, arguments.ubicacion, arguments.turno),
        builder: (context, snapshot) {
            if(snapshot.hasData){
              if(snapshot.data.isEmpty) return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sin resultados", style: TextStyle(fontSize: 18)),
                ],
              );
                  return _createItem( lista: snapshot.data );
              }
            return new Center(
              child: new CircularProgressIndicator(),
            );
          },
      ),
    );
  }


  Widget _createItem({List lista}) {
      ParametroBusqueda arguments = ModalRoute.of(context).settings.arguments;
      return ListView.builder(
        itemCount: lista == null ? 0: lista.length,
        itemBuilder: (context, index) {
      return GestureDetector( 
        onTap: () async {
          List<dynamic> listaDatos = await TraerDatos.misDatos(lista[index]['id']);
          // print(listaDatos);
          Navigator.of(context).pushNamed("/recuperarDatos", arguments: MisDatosParam(
                                            ci: listaDatos[0]['ci'].toString(),
                                            nombre: listaDatos[0]['nombre'],
                                            direccion: listaDatos[0]['direccion'],
                                            email: listaDatos[0]['email'],
                                            telef: listaDatos[0]['telefono'].toString(),
                                            servicios: listaDatos[0]['servicios'],
                                            imagen: listaDatos[0]['img_perfil']
                                            ));

        },
        child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:20, top: 20),
            child: Container(
              width: 320,
              height: 130,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 15),
                    child: Image.network("https://fotografias.lasexta.com/clipping/cmsimages02/2019/11/14/66C024AF-E20B-49A5-8BC3-A21DD22B96E6/58.jpg",width: 80)
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

                    Operacion.textosEstilosDif("Turno: " + arguments.turno)
                    ]
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: const BorderRadius.all(const Radius.circular(20)),
                color: Colors.cyan[100],
              ),
            ),
          ),
        ],
      ),
     );
    }
    );
  }

   _serviciosString(List<dynamic> listaServicios) {

      String listaServi = "";
      for (var i = 0; i < listaServicios.length; i++) {
        if(i == listaServicios.length-1)
          listaServi = listaServi + listaServicios[i]['nombre'];
        else 
          listaServi = listaServi + listaServicios[i]['nombre'] + "-";
        
      }
      return listaServi;
  }


}

class ParametroBusqueda{
  String servicio;
  String ubicacion;
  String turno;

  ParametroBusqueda({this.servicio, this.ubicacion, this.turno});
}