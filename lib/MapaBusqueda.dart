
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';


class MapaBusqueda extends StatefulWidget {
  _MapaBusquedaState createState() => _MapaBusquedaState();
}



class _MapaBusquedaState extends State<MapaBusqueda> {
  
GoogleMapController mapController;
MapType _defaultMapType = MapType.normal;

CameraPosition _initialPosition = CameraPosition(target: LatLng(-17.814581, -63.1560853),
                                                 zoom: 10);
String buscarDireccion;

List<Marker> myMarker = [];

LatLng latlong;

@override
void initState() {
  requestPermission();
  super.initState();
}

void _changeMapType() {
  setState(() {
    _defaultMapType = _defaultMapType == MapType.normal ? MapType.satellite : MapType.normal;
  });
}


Future<void> requestPermission() async { await Permission.location.request(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(20),),
                  color: Colors.white,
                  border: Border.all(color: Colors.cyan[100], width: 3)
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Ingrese Direccion a Buscar',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        color: Colors.cyan[300],
                        onPressed: () {
                          return barraBusqueda();
                        },
                        iconSize: 30.0,
                      )                             
                  ),
                  onChanged: (val) {
                    setState(() {
                      buscarDireccion = val; 
                    });
                  }
                ),
              ),
        ],
      ),
       body: Stack(
         children: <Widget>[

           GoogleMap(
             onMapCreated: onMapCreated,
             mapType: _defaultMapType,
             initialCameraPosition: _initialPosition,
             myLocationEnabled: true,
             myLocationButtonEnabled: true,
             markers: Set.from(myMarker),
             onTap: _handleTap,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 35.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        alignment: Alignment.topLeft,
                        child: FloatingActionButton(
                          heroTag: "arrow_back",
                            child: Icon(Icons.arrow_back),
                            elevation: 5,
                            backgroundColor: Colors.teal[200],
                            onPressed: () {
                              Navigator.pop(context, latlong);
                            }),
                      ), 

                      Container(
                        margin: EdgeInsets.only(right: 10),
                        alignment: Alignment.topLeft,
                        child: FloatingActionButton(
                            heroTag: "choice_state",
                            child: Icon(Icons.layers),
                            elevation: 5,
                            backgroundColor: Colors.teal[200],
                            onPressed: () {
                              _changeMapType();
                              print('Changing the Map Type');
                            }),
                      ),                     
                      
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  _handleTap(LatLng tappedPoint){
    print(tappedPoint);
    setState(() {
      myMarker = [];
      myMarker.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          draggable: true,
          onDragEnd: (dragEndPosition){
            print(dragEndPosition);
          }
        )
      );
      this.latlong = tappedPoint;
    });
  }

  barraBusqueda(){

      locationFromAddress(buscarDireccion).then((result) async {
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(result[0].latitude, result[0].longitude),
                zoom: 10.0
              )
            )
          );
          
          // print("Latitud: ${result[0].position.latitude}");
          // print("Longitud: ${result[0].position.longitude}");
          
          LatLng tappedPoint = LatLng(result[0].latitude, result[0].longitude);  
          setState(() {
            myMarker = [];
            myMarker.add(
              Marker(
                markerId: MarkerId(tappedPoint.toString()),
                position: tappedPoint,
                draggable: true,
                onDragEnd: (dragEndPosition){
                  print(dragEndPosition);
                }
              )
            );
            this.latlong = tappedPoint;
          });
    }).catchError((e){
      print(e);
    });
    
  }

   _showSnackbar(BuildContext context){
    SnackBar snackbar= SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Registro satisfactorio",
                        style: TextStyle(fontSize: 18,
                        color: Colors.black
                        )
           ),
        ],
      ),
      backgroundColor: Color(0xff5DBFA6) 
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }
          
  void onMapCreated(controller) {
    setState(() {
    mapController = controller; 
    });
  }

}