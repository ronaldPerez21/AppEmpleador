import 'package:busqueda/api/Peticiones.dart';
import 'package:busqueda/screens/ListaServicios.dart';
import 'package:busqueda/screens/modals/FiltrosServicios.dart';
import 'package:busqueda/screens/modals/RadioList.dart';
import 'package:busqueda/screens/modals/buscador.dart';
import 'package:flutter/material.dart';

class ListaTrabajos extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListaTrabajosF(),
    );
  }


}

class ListaTrabajosF extends StatefulWidget{

  ListaTrabajosState createState() => ListaTrabajosState();
}

class ListaTrabajosState extends State<ListaTrabajosF>{

  var listServices;
  String selectService = "Todos";
  String selectTurno = "Todos";
  String selectUbicacion = "Todos";

  void initState(){
    super.initState();
    loadServices();
  }

  Future<Null> loadServices() async {
    var auxLista = await TraerDatos.getServiciosM();
    setState((){
      listServices= auxLista;
    });
    return null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('Lista de Trabajos'),
        backgroundColor: Color(0xff5DBFA6),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: (){
              _modalBottomSheet(context);
            },
          ),

          IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Buscar',
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(listServices),
                );
              }
          ),

        ],
      ),
      body: ListaServicios(TraerDatos.getTodosServicios()),
      drawer: _getDrawer(context)
    );
  }

    Widget _getDrawer(BuildContext context){
    return Container(
      width: 200,
      child: Drawer(
      child: ListView(
        children: <Widget>[
          //Esto es una forma, pero tambien podemos hacerlo con el UserAccountsDrawerHeader, ej:
            DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff5DBFA6)
              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.account_box,
                  size: 40,
                  ),
                
                  Text("Mis Datos",
                  style: TextStyle(color: Colors.black, fontSize: 20)
                  ) 
                      
             ],
           )
          ),

          Card(
            color: Color(0xff5DBFA6),
            child: ListTile(
            title: Text("Solicitudes", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            leading: Icon(Icons.search),
            onTap: ()=>Navigator.of(context).pushNamed("/historial")
            )
          )
        ],
        ),
      )
    );
  }
  
  void _modalBottomSheet(context){

    showModalBottomSheet(context: context,
     shape : RoundedRectangleBorder(
            borderRadius : BorderRadius.only(topLeft: const Radius.circular(20),
                                             topRight: const Radius.circular(20))
     ),
     builder: (BuildContext bc){
      return Container(
        height: MediaQuery.of(context).size.height * .60,
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, size: 25),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
                // Spacer(),

                Padding(
                  padding: const EdgeInsets.only(left: 115),
                  child: Text("Filtros", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Spacer(),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: Text("Reestablecer", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  onTap:(){
                    _deleteOpciones();
                    Navigator.pop(context); //No es lo correcto
                    _modalBottomSheet(context);
                  }
                ),

              ],
            ),
            _opciones(context, "Servicios", selectService),

            _opciones(context, "Turnos", selectTurno),

            _opciones(context, "Ubicacion", selectUbicacion),
            
            Container(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonTheme(
                  minWidth: 200,
                  child: RaisedButton(
                        child: Text("Ver Servicios"),
                        onPressed: () async {
                          if(selectService == "Todos" && selectTurno == "Todos")
                            Navigator.pop(context);
                          else
                            Navigator.of(context).pushNamed(
                              "/busquedaDatos",
                              arguments: ParametroBusqueda(
                                servicio: selectService,
                                ubicacion: selectUbicacion,
                                turno: turnoInt(selectTurno).toString()
                              )
                            );
                        },
                        color: Colors.cyan[200],
                        textColor: Colors.black,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        splashColor: Colors.grey,
                        shape : RoundedRectangleBorder(
                        borderRadius : BorderRadius.all(const Radius.circular(10),)
                        ),
                  ),
                ),
              ],
            )
          ],
        )
      );
    });
  }

  _opciones(context, String nombreTitle, String nombreSubtitle){
    return Row(
      children: [
        
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(nombreTitle, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(nombreSubtitle),
            ),
          ],
        ),
        
        Spacer(),

        IconButton(
          icon: Icon(Icons.arrow_forward_ios, size: 25),
          onPressed: ()async {
            final result = await Navigator.of(context).push(
                            MaterialPageRoute( builder: (context) => RadioList(
                              nombreTitle
                            ) ),
                          ).whenComplete((){ 
                            Navigator.pop(context);
                            _modalBottomSheet(context);
                          }); 

            print(result);
            if(result != null){
              setState(() {
                switch(nombreTitle){
                  case "Servicios": selectService = result; break;
                  case "Ubicacion": selectUbicacion = result; break;
                  case "Turnos": selectTurno = result; break;

                }
              });
            }
          },
        ),
        
      ],
    );
  }

  _deleteOpciones(){
    setState(() {
      selectService = "Todos";
      selectUbicacion = "Todos";
      selectTurno = "Todos";
    });
  }

  int turnoInt(String s){
   
   switch(s){
     case 'Mañana': return 1;
     break;
     case 'Tarde': return 2;
     break;
     case 'Noche': return 3;
     break;
     default: return -1;
   }
 }
  
}
