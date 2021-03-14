
import 'package:flutter/material.dart';

class Solicitud extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(title: Text("Solicitud"), backgroundColor: Color(0xff5DBFA6),),
      body: BusquedaFul()
      );
  }

}

class BusquedaFul extends StatefulWidget{
  BusquedaState createState() => BusquedaState();
}

class BusquedaState extends State<BusquedaFul>{
  final _formKey = GlobalKey<FormState>();

  List<dynamic> controladores = List<dynamic>(); 
  List<dynamic> _servicios = List<String>();



  @override
  Widget build(BuildContext context) {
    Servicios arguments = ModalRoute.of(context).settings.arguments;
    setState(() {
      _servicios = arguments.nomServicios;
      initController();
    });
    return Scaffold(
      body: Column(
        children: [
          Expanded(
          child: _mostrarServicios(context, _servicios)
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
                  for (var i = 0; i < controladores.length; i++) {
                    print("$i ${controladores[i]['ubicacion'].text}");
                    print("$i ${controladores[i]['descripcion'].text}");
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
    );
  }

  

  _mostrarServicios(BuildContext context, List<dynamic> servi){

    return ListView.builder(
        itemCount: servi == null ? 0: servi.length,
        itemBuilder: (BuildContext context, index) {
              return Card(
                color: Colors.teal[100],
                    margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                          children: <Widget>[

                            Text(servi[index]['nombre'],  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                            Padding(
                              padding: const EdgeInsets.only(left: 30.0, top: 20, right: 30),
                              child: Row(
                                children: [
                                  Text("Agregar dirección", style: TextStyle(fontSize: 18)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30, right: 30),
                              child: TextFormField(
                                  controller: controladores[index]['ubicacion'],
                                  validator: (value){
                                    if(value.isEmpty){ return "Campo vacío"; }
                                    
                                  },
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Dirección",
                                    fillColor: Colors.grey[300],
                                    filled: true
                                  ),
                                ),
                            ),
                              
                              Padding(
                                padding: const EdgeInsets.only(left: 30, top: 40, right: 30),
                                child: Row(
                                  children: [
                                    Text("Describa su problema", style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30, right: 30),
                                child: TextFormField(
                                  controller: controladores[index]['descripcion'],
                                  validator: (value){
                                    if(value.isEmpty){ return "Campo vacío"; }
                                    
                                  },
                                  maxLines: 10,
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
              );
        },
    );

  }

  strToList(String s){
    String cad = "";
    List<String> L = List<String>();
    for(int i = 0; i < s.length; i++){
      if(s.substring(i, i+1) == '-') { L.add(cad); cad = ""; } 
      else cad = cad + s.substring(i, i+1);
    }
    L.add(cad);
    return L;
  }

  initController(){
    List<dynamic> servi = List<dynamic>();
    for (var i = 0; i < _servicios.length; i++) {
      servi.add({
        'ubicacion': new TextEditingController(),
        'descripcion': new TextEditingController()
      });
    }
    setState(() {
      controladores = servi;
    });
  }

}

class Servicios{
  List<dynamic> nomServicios;
  Servicios({this.nomServicios});
}