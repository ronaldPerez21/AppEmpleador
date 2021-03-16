
import 'package:busqueda/api/Peticiones.dart';
import 'package:busqueda/screens/modals/operaciones.dart';
import 'package:busqueda/screens/solicitar.dart';
import 'package:flutter/material.dart';
import 'Mapa.dart';

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
  List<RoundedRectangleBorder> drawBorder = List<RoundedRectangleBorder>();
  List<dynamic> serviciosSelect = List<dynamic>();

  Map<String,dynamic> resultSolicitud;

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
      for (var i = 0; i < arguments.cantServicios; i++) {
      drawBorder.add(new RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), ),);
      }

      return FutureBuilder<List<dynamic>>(
        future: TraerDatos.misDatos(arguments.id),
        builder: (context, snapshot){
          if(snapshot.hasData){
            List listDatos = snapshot.data;
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
                              Text(listDatos[0]['nombre'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                            ]
                          ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RaisedButton(
                                    color: Color(0xff5DBFA6),
                                    textColor: Colors.black,
                                    child: Text("Solicitar"),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    onPressed: () async {
                                      print("select Servi: ${this.serviciosSelect}");
                                      // print(listDatos[0]['persona_id']);
                                      
                                      // for (var i = 0; i < this.serviciosSelect.length; i++) {
                                      //   if(this.serviciosSelect[i]['resultado'] != null){
                                      //     if(this.serviciosSelect[i]['resultado']['ubicacion'] != null){
                                      //       await TraerDatos.solictarServicio(
                                      //         this.serviciosSelect[i]['id'],
                                      //         listDatos[0]['persona_id'], 
                                      //         this.serviciosSelect[i]['descripcion'], 
                                      //         this.serviciosSelect[i]['resultado']['ubicacion'], 
                                      //         this.serviciosSelect[i]['resultado']['ubicacion']);
                                      //     }
                                      //   }
                                      // }
                                    }
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: GestureDetector(
                                      child: Column(
                                        children: [
                                          Text("Ver ubicación", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Icon(Icons.location_on, color: Colors.red)
                                        ],
                                      ),
                                      onTap: (){
                                        Mapa mapa = Mapa(-17.814581, -63.1560853);
                                        mapa.initState();
                                        return mapa.alertDialog(context);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Operacion.getIconDatos(Icon(Icons.assignment_ind), "CI: " + listDatos[0]['ci'].toString()),
                    ),
                    Operacion.getIconDatos(Icon(Icons.location_on), "Dirección: " + listDatos[0]['direccion']),
                    Operacion.getIconDatos(Icon(Icons.email), "Email: " + listDatos[0]['email']),
                    Operacion.getIconDatos(Icon(Icons.call), "Teléfono: " + listDatos[0]['telefono'].toString()),

                    Column(
                      children: [
                        Operacion.getIconDatos(Icon(Icons.work), "Servicios: "),

                          Container(
                          height: 50,
                            child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listDatos[0]['servicios'] == null ? 0: listDatos[0]['servicios'].length,
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
                                        child: Text(listDatos[0]['servicios'][index]['nombre']),
                                        shape: drawBorder[index],
                                        onPressed: () {
                                          _alertDialogServicios(context, listDatos[0]['servicios'], index);
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
              
          }else
            return Center(
              child: CircularProgressIndicator()
            );
        }
      );
              
    
  }



   _alertDialogServicios(BuildContext context, servicios, i){

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
            height: 130,
            child: Column(
              children: [

                dibujarDias(servicios[i]['dias']),

                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text ("Hora de inicio: " + servicios[i]['hora_inicio']),
                      Text("Hora de finalización: " + servicios[i]['hora_fin']),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonTheme(
                            height: 30,
                            child: RaisedButton(
                              color: Color(0xff5DBFA6),
                              textColor: Colors.black,
                              child: Text("Solicitar"),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), ),
                              onPressed: () async{
                                 final result = await Navigator.of(context).push(
                                      MaterialPageRoute( builder: (context) => Solicitud(servicios[i]['nombre'])),
                                    ); 
                                  setState(() {
                                    resultSolicitud = result;
                                  });
                              }
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: ButtonTheme(
                              height: 30,
                              child: RaisedButton(
                                color: Color(0xff5DBFA6),
                                textColor: Colors.black,
                                child: Text("Desmarcar"),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), ),
                                onPressed: () {
                                  setState(() {
                                    this.resultSolicitud = null;
                                    this.drawBorder[i] = RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), );
                                    for (var j = 0; j < this.serviciosSelect.length; j++) {
                                      if(this.serviciosSelect[j]['id'] == servicios[i]['servicio_id'])
                                        this.serviciosSelect.removeAt(j);
                                    }
                                  });
                                }
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                ),
                
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                if(resultSolicitud != null){ 
                  if(this.resultSolicitud['descripcion'].isNotEmpty){
                    setState(() {
                          drawBorder[i] = RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),                          
                                  side: BorderSide(width: 3, color: Colors.blue[900]));
                            this.serviciosSelect.add({
                              'id': servicios[i]['servicio_id'],
                              'nombre': servicios[i]['nombre'],
                              'resultado': this.resultSolicitud
                            }
                          );
                    });
                  }
                }
                Navigator.pop(context); 
                }
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

  // _serviciosString(List<dynamic> listaServicios) {

  //     String listaServi = "";
  //     for (var i = 0; i < listaServicios.length; i++) {
  //       if(i == listaServicios.length-1)
  //         listaServi = listaServi + listaServicios[i]['nombre'];
  //       else 
  //         listaServi = listaServi + listaServicios[i]['nombre'] + "-";
        
  //     }
  //     return listaServi;
  // }

  // _selectComboBoxCalificar(){
  //    return new DropdownButton(
  //               value: selectCalif,
  //               items: calificacion.map((item){
  //                   return DropdownMenuItem(
  //                     child: Text(item),
  //                     value: item 
  //                     );
  //                 }).toList(),
  //               onChanged: (value){
  //                 setState(() {
  //                   selectCalif = value;
  //                 });
  //               }
  //             );
    
  // }

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
      body: FutureBuilder<List<dynamic>>(
        future: TraerDatos.misDatos(arguments.id),
        builder: (context, snapshot){
          if(snapshot.hasData){
            List listDatos = snapshot.data;
            return Stack(
              fit: StackFit.expand,
              overflow: Overflow.visible,
              children: [
                Container(
                  color: Color(0xff5DBFA6),
                ),
                Center(
                  child: AppBar(title: Text(listDatos[0]['nombre']), backgroundColor: Colors.black12,)
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
            ); 
          }else
            return Center(
              child: CircularProgressIndicator()
            );
        }
      )        
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
  String id;
  int cantServicios;
  MisDatosParam({this.id, this.cantServicios});
}