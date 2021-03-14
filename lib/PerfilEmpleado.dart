import 'package:busqueda/solicitar.dart';
import 'package:busqueda/traerDatos.dart';
import 'package:flutter/material.dart';

import 'operaciones.dart';

class RecuperarDatos extends StatelessWidget{
    @override
  Widget build(BuildContext context) {
      return WillPopScope( //Para controlar el boton de retroceso
        onWillPop: () async { //Con esto se puede controlar el boton de retroceso pero hay un parpadeo cuando se retrocede
          await Navigator.of(context).pop();
          //Navigator.popAndPushNamed(context, "/");
          return true;
          },
        child: Scaffold(
          body: RecuperarDatosF()
        )
      );
  }
}

class RecuperarDatosF extends StatefulWidget{
  
  RecuperarDatosState createState() => RecuperarDatosState();
}

class RecuperarDatosState extends State<RecuperarDatosF> {

  List calificacion = ["1","2","3","4","5"];
  String selectCalif = "1";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MisDatos(expandedHeight: 200),
              pinned: true,
            ),
            SliverList(
              
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, index) { 
                  return _misDatos(context);
                },
                childCount: 1
              ),
            )
          ],
        ),
      ),
    );
  }

    _misDatos(BuildContext context) {
    MisDatosParam arguments = ModalRoute.of(context).settings.arguments;
      print(arguments.servicios);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children :[
                    Text(arguments.nombre, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                  ]
                ),
                  RaisedButton(
                    color: Color(0xff5DBFA6),
                    textColor: Colors.black,
                    child: Text("Solicitar"),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    onPressed: (){
                       Navigator.of(context).pushNamed("/solicitud", arguments: Servicios(
                                                                      nomServicios: arguments.servicios));
                      // return _alertDialog(context);
                    }
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Operacion.getIconDatos(Icon(Icons.assignment_ind), "CI: " + arguments.ci),
          ),
          Operacion.getIconDatos(Icon(Icons.location_on), "Dirección: " + arguments.direccion),
          Operacion.getIconDatos(Icon(Icons.email), "Email: " + arguments.email),
          Operacion.getIconDatos(Icon(Icons.call), "Teléfono: " + arguments.telef),

          Column(
            children: [
              Operacion.getIconDatos(Icon(Icons.work), "Servicios: "),

                Container(
                 height: 50,
                  child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: arguments.servicios == null ? 0: arguments.servicios.length,
                  itemBuilder: (BuildContext context, index) {
                    return Column(
                      children: [
                       
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ButtonTheme(
                            height: 30,
                            child: RaisedButton(
                              color: Color(0xff5DBFA6),
                              textColor: Colors.black,
                              child: Text(arguments.servicios[index]['nombre']),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              onPressed: () {
                                _alertDialog(context, arguments.servicios, index);
                              }
                            ),
                          ),
                        ),
                      ],
                    );
                  },
              ),
                )
            ]
          ),
          Container(
            height: 250
          )
        ],
      );
              
    
  }



   _alertDialog(BuildContext context, servicios, i){

    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(servicios[i]['nombre'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ],
          ),
          content: Container(
            height: 90,
            child: Column(
              children: [

                dibujarDias(servicios[i]['dias']),

                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text ("Hora de inicio: " + servicios[i]['hora_inicio']),
                      Text("Hora de finalización: " + servicios[i]['hora_fin'])
                    ],
                  ),
                ),
                
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () { Navigator.pop(context); }
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        );
      }, 
      barrierDismissible: false
    );
 }

 dibujarDias(String dias){
   List diasArr = dias.split(",");
   return SizedBox(
     height: 25,
     width: 200,
     child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: diasArr == null ? 0: diasArr.length,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                            color: Color(0xff5DBFA6),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child: Text(diasArr[index]))
                          ),
                      );
                    },
     ),
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

  _selectComboBoxCalificar(){
     return new DropdownButton(
                value: selectCalif,
                items: calificacion.map((item){
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item 
                      );
                  }).toList(),
                onChanged: (value){
                  setState(() {
                    selectCalif = value;
                  });
                }
              );
    
  }

  // Future<Null> refrescar() async {
  //   MisDatosParam arguments = ModalRoute.of(context).settings.arguments;
  //   String cal = await TraerDatos.calificar(selectCalif, arguments.ci, arguments.idServi);
  //   await new Future.delayed(new Duration(milliseconds: 1));
  //   setState((){
  //     // arguments.calif = cal;
  //   });
  //   return null;
  // }

}

class MisDatos extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MisDatos({@required this.expandedHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    
    MisDatosParam arguments = ModalRoute.of(context).settings.arguments;
  
    return Scaffold(
      body: Stack(
            fit: StackFit.expand,
            overflow: Overflow.visible,
            children: [
              Container(
                color: Color(0xff5DBFA6),
              ),
              Center(
                child: AppBar(title: Text(arguments.nombre), backgroundColor: Colors.black12,)
              ),
              Positioned(
                top: expandedHeight / 2 - shrinkOffset,
                left: MediaQuery.of(context).size.width / 3.5,
                child: Opacity(
                  opacity: (1 - shrinkOffset / expandedHeight),
                  child: Container(
                    
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green, width: 3),
                      
                      image: DecorationImage(
                        image: NetworkImage("https://fotografias.lasexta.com/clipping/cmsimages02/2019/11/14/66C024AF-E20B-49A5-8BC3-A21DD22B96E6/58.jpg"),
                        fit: BoxFit.contain
                      ),
                    ),

                    child: SizedBox(
                      height: expandedHeight,
                      width: MediaQuery.of(context).size.width / 2.5,
                      
                    ),
                  ),
                ),
              ),
            ],
          ),           
    );
  }


  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}


class MisDatosParam{
  String ci;
  String nombre;
  String direccion;
  String email;
  String telef;
  List<dynamic> servicios;
  String imagen;

  MisDatosParam({this.ci, this.nombre, this.direccion, this.email, this.telef, this.servicios, this.imagen});
}