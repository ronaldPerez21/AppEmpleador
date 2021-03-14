import 'package:busqueda/buscador.dart';
import 'package:busqueda/datosBusqueda.dart';
import 'package:busqueda/PerfilEmpleado.dart';
import 'package:busqueda/RadioList.dart';
import 'package:busqueda/traerDatos.dart';
import 'package:flutter/material.dart';
import 'operaciones.dart';

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

  var lista;
  String selectService = "Todos";
  String selectTurno = "Todos";
  String selectUbicacion = "Todos";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Lista de Trabajos"), backgroundColor: Color(0xff5DBFA6),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: (){
              _modalBottomSheet(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(context: context, delegate: DataSearch())
          )
        ],
      ),
      body: createItem(),
      // drawer: _getDrawer(context),
    );
  }

  void initState(){
    super.initState();
    refrescar();

  }

  Future<Null> refrescar() async {
    await new Future.delayed(new Duration(milliseconds: 1));
    var auxLista = await TraerDatos.getTodosServicios();
    setState((){
      lista = auxLista;
    });
    return null;
  }

  Widget createItem() {

      return RefreshIndicator( 
      child: ListView.builder(
        itemCount: lista == null ? 0: lista.length,
        itemBuilder: (context, index) {
      return GestureDetector( 
        onTap: () async {
          List<dynamic> listaDatos = await TraerDatos.misDatos(lista[index]['id']);
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

                    Operacion.textosEstilosDif("Turno: " )
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
    ),
    onRefresh: refrescar,
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
