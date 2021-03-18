import 'package:busqueda/screens/HistorialSolicitud.dart';
import 'package:busqueda/screens/detalleHistorial.dart';
import 'package:busqueda/screens/modals/FiltrosServicios.dart';
import 'package:busqueda/screens/modals/PerfilEmpleado.dart';
import 'package:flutter/material.dart';

import 'screens/Index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
    //Se indica que el tema tiene un brillo luminoso/claro
    brightness: Brightness.light,
    primarySwatch: Colors.cyan,
  ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => ListaTrabajos(),
        "/busquedaDatos": (BuildContext context) => DatosBusqueda(),
        "/recuperarDatos": (BuildContext context) => RecuperarDatos(),
        "/historial": (BuildContext context) => HistorialSolicitudes(),
        "/detalleSolicitud": (BuildContext context) => DetalleHistorial(),
        // "/solicitud": (BuildContext context) => Solicitud(),
      }
    );
  }
}


// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:loadmore/loadmore.dart';


// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Flutter Demo',
//       theme: new ThemeData(
//         primarySwatch: Colors.red,
//       ),
//       home: new MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   int get count => list.length;

//   List<int> list = [];

//   void load() {
//     print("load");
//     setState(() {
//       list.addAll(List.generate(15, (v) => v));
//       print("data count = ${list.length}");
//     });
//   }

//   Future<bool> _loadMore() async {
//     print("onLoadMore");
//     await Future.delayed(Duration(seconds: 5));
//     load();
//     return true;
//   }

//   Future<void> _refresh() async {
//     await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
//     list.clear();
//     load();
//   }

//    @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text(widget.title),
//       ),
//       body: Container(
//         child: RefreshIndicator(
//           child: LoadMore(
//             isFinish: count >= 60,
//             onLoadMore: _loadMore,
//             child: ListView.builder(
//               itemBuilder: (BuildContext context, int index) {
//                 print("Lista: $list");
//                 return Container(
//                   child: Text(list[index].toString()),
//                   height: 40.0,
//                   alignment: Alignment.center,
//                 );
//               },
//               itemCount: count,
//             ),
//             whenEmptyLoad: false,
//             delegate: DefaultLoadMoreDelegate(),
//             textBuilder: DefaultLoadMoreTextBuilder.chinese,
//           ),
//           onRefresh: _refresh,
//         ),
//       ),
//     );
//   }

// }
