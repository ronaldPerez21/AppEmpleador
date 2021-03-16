import 'package:busqueda/api/Peticiones.dart';
import 'package:flutter/material.dart';


class RadioList extends StatefulWidget {
  // List<String> choice;
  String titleAppBar;
  RadioList(this.titleAppBar);
  @override
  RadioListState createState() => RadioListState();
}

class RadioListState extends State<RadioList>{
 
  String default_choice;
  int default_index;  
  List<String> choice;

  @override
  Widget build(BuildContext context) {
    
    // choice = widget.choice;
    return WillPopScope(
      onWillPop: () {
          Navigator.pop(context, default_choice);
      },

      child: Scaffold(
        appBar: AppBar(title: Text(widget.titleAppBar), backgroundColor: Color(0xff5DBFA6),),
        body: _drawList(context)
      ),
    );
  }

  _drawList(context){
    switch(widget.titleAppBar){
      case "Servicios":
        return FutureBuilder<List>(
          future: TraerDatos.getServiciosM(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return _drawRadioList(snapshot.data);
            }
            else
              return Center(
                child: new CircularProgressIndicator(),
              );
          }
          ); break;
      case "Ubicacion": 
        return FutureBuilder<List>(
        future: TraerDatos.getLugaresM(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return _drawRadioList(snapshot.data);
          }
          else
            return Center(
              child: new CircularProgressIndicator(),
            );
        }
        ); break;
      case "Turnos":
        return _drawRadioList(["Mañana", "Tarde", "Noche"]); break;
    }

  }

  _drawRadioList(choice){
    return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: choice == null? 0 : choice.length,
                itemBuilder: (context, index){
                  return RadioListTile(
                          title: Text(choice[index]),
                          groupValue: default_index,
                          value: index,
                          onChanged: (value){
                            setState(() {
                              default_choice = choice[index];
                              default_index = index;
                              
                            });
                          },
                  );
                  
                }
  
              ),
            ),
          ],
        );
  }

}
