
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'modals/MapaBusqueda.dart';


class Solicitud extends StatefulWidget{
  String nomServicio;
  Solicitud(this.nomServicio);
  SolicitudState createState() => SolicitudState();
}

class SolicitudState extends State<Solicitud>{
  final _formKey = GlobalKey<FormState>();

  TextEditingController serviceController = TextEditingController();
  LatLng latlong;
  Map<String, dynamic> datos;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        datos = {
          'ubicacion': latlong,
          'descripcion': serviceController.text
        };

        Navigator.pop(context, datos);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Solicitud"),
          backgroundColor: Color(0xff5DBFA6),
          actions: [
            Row(
              children: [
                Text("Marcar", style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.location_on),
                  onPressed: ()async {
                    final result = await Navigator.of(context).push(
                              MaterialPageRoute( builder: (context) => MapaBusqueda(
                              ) ),
                            ); 
                    print("LatLong: $result");
                    setState(() {
                      this.latlong = result;
                    });
                  },
                ),
              ],
            ),
            
          ],
        ),
        body: Column(
          children: [
            Expanded(
            child: _mostrarServicios(context, widget.nomServicio)
            ), 

            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xff5DBFA6),
                ),
                child: FlatButton(
                  onPressed: () { 
                    if(_formKey.currentState.validate()){
                      datos = {
                        'ubicacion': this.latlong,
                        'descripcion': serviceController.text
                      };
                      Navigator.pop(context, datos);
                    }
                  },
                  child: Text(
                    'Continuar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ]
        )
      ),
    );
  }

  

  _mostrarServicios(BuildContext context, String servi){
  return Card(
      color: Colors.teal[100],
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Descripción de " + servi,  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: serviceController,
                    validator: (value){
                      if(value.isEmpty){ return "Campo vacío"; }
                      
                    },
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Descripción del problema",
                      fillColor: Colors.grey[300],
                      filled: true
                    ),
                  ),
                ),
              ]
            ),
        ),
      ),
    );

  }

}




// class SolicitudState extends State<Solicitud>{
//   final _formKey = GlobalKey<FormState>();

//   List<TextEditingController> controladores = List<TextEditingController>(); 
//   List<dynamic> _servicios = List<String>();



//   @override
//   Widget build(BuildContext context) {
//     Servicios arguments = ModalRoute.of(context).settings.arguments;
//     setState(() {
//       _servicios = arguments.nomServicios;
//       initController();
//     });
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Solicitud"),
//         backgroundColor: Color(0xff5DBFA6),
//         actions: [
//           Row(
//             children: [
//               Text("Marcar", style: TextStyle(fontWeight: FontWeight.bold)),
//               IconButton(
//                 color: Colors.red,
//                 icon: Icon(Icons.location_on),
//                 onPressed: ()async {
//                   final result = await Navigator.of(context).push(
//                             MaterialPageRoute( builder: (context) => MapaBusqueda(
//                             ) ),
//                           ); 
//                   print("LatLong: $result");
//                 },
//               ),
//             ],
//           ),
          
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//           child: _mostrarServicios(context, _servicios)
//           ), 

//           Padding(
//             padding: const EdgeInsets.only(bottom: 8.0),
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.08,
//               width: MediaQuery.of(context).size.width * 0.8,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Color(0xff5DBFA6),
//               ),
//               child: FlatButton(
//                 onPressed: () { 
//                   for (var i = 0; i < controladores.length; i++) {
//                     print("$i ${controladores[i].text}");
//                   }
//                 },
//                 child: Text(
//                   'Continuar',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//         ]
//       )
//     );
//   }

  

//   _mostrarServicios(BuildContext context, List<dynamic> servi){

//     return ListView.builder(
//         itemCount: servi == null ? 0: servi.length,
//         itemBuilder: (BuildContext context, index) {
//               return Card(
//                 color: Colors.teal[100],
//                     margin: EdgeInsets.all(8),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text("Descripción de " + servi[index]['nombre'],  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10),
//                         child: TextFormField(
//                           controller: controladores[index],
//                           validator: (value){
//                             if(value.isEmpty){ return "Campo vacío"; }
                            
//                           },
//                           maxLines: 3,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: "Descripción del problema",
//                             fillColor: Colors.grey[300],
//                             filled: true
//                           ),
//                         ),
//                       ),
//                     ]
//                   ),
//               ),
//               );
//         },
//     );

//   }

//   strToList(String s){
//     String cad = "";
//     List<String> L = List<String>();
//     for(int i = 0; i < s.length; i++){
//       if(s.substring(i, i+1) == '-') { L.add(cad); cad = ""; } 
//       else cad = cad + s.substring(i, i+1);
//     }
//     L.add(cad);
//     return L;
//   }

//   initController(){
//     List<TextEditingController> servi = List<TextEditingController>();
//     for (var i = 0; i < _servicios.length; i++) {
//       servi.add(new TextEditingController());
//     }

//     setState(() {
//       controladores = servi;
//     });
//   }

// }

// class Servicios{
//   List<dynamic> nomServicios;
//   Servicios({this.nomServicios});
// }