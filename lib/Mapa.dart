import 'dart:async';
import 'package:busqueda/PerfilEmpleado.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';




class Mapa extends State<RecuperarDatosF>{

double latitud;
double longitud;

Mapa(this.latitud, this.longitud);

Completer<GoogleMapController> _controller = Completer();

MapType _defaultMapType = MapType.normal;

CameraPosition _initialPosition;

List<Marker> myMarker = [];

final double _zoom = 12;

@override
void initState() {
  _initialPosition = CameraPosition(target: LatLng(latitud, longitud),
                                                 zoom: _zoom);

  myMarker.add(
    Marker(
          markerId: MarkerId(LatLng(latitud, longitud).toString()),
          position: LatLng(latitud, longitud),
          draggable: true,
          onDragEnd: (dragEndPosition){
            print(dragEndPosition);
          }
    )
  );

  requestPermission();
  super.initState();
}

void changeMapType() {
  setState(() {
    _defaultMapType = _defaultMapType == MapType.normal ? MapType.satellite : MapType.normal;
  });
}

void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
}

Future<void> requestPermission() async { await Permission.location.request(); }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       body: Center(
         child: RaisedButton(
           child: Text("Press", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
           color: Colors.cyan,
           onPressed: () {
             alertDialog(context);
           },
         ),
       )
    );
  }


  alertDialog(BuildContext context){

    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Ubicación", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ],
          ),
          content: Stack(children: [ //container con height:250
            GoogleMap(
              onMapCreated: (controller){
                _controller.complete(controller);
              },
              mapType: _defaultMapType,
              initialCameraPosition: _initialPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: Set.from(myMarker),
             ),
          //  Positioned(
          //     bottom: 40,
          //     left: 20,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         Row(
          //           children: [
          //             Container(
          //               margin: EdgeInsets.only(right: 10),
          //               alignment: Alignment.topLeft,

          //               child: Container(
          //                 width: 30,
          //                 height: 30,
          //                 child: FittedBox(
          //                   child: FloatingActionButton(
          //                       child: Icon(Icons.layers),
          //                       elevation: 5,
          //                       backgroundColor: Colors.teal[200],
          //                       onPressed: () {
          //                         changeMapType();  
          //                         print('Changing the Map Type');
          //                       }),
          //                 ),
          //               ),
          //             ),                     
                      
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),

          ],),
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

}