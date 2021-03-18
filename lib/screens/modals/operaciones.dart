import 'package:flutter/material.dart';

class Operacion{

  static textosEstilosDif(String valor, {TextStyle estilo}){
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: valor,
              style: estilo
          )
        ],
      ),
    );
  }

  static textStyleTitleSubtitle(Icon icono, title, subtitle, double size){
    return Card(
      child: Row(
        children: [
          icono,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: title,
                        style: TextStyle(
                          fontSize: size,
                          fontWeight: FontWeight.bold
                        )),
                    TextSpan(
                        text: ' ',
                        style: TextStyle(fontSize: size)
                    ),

                    TextSpan(
                      text: subtitle,
                      style:  TextStyle(fontSize: size)
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  static nivelCalificacion(int n){
    List<Icon> estrellas = new List();
    for(int i = 1; i<=5; i++){
      if(i<=n)
        estrellas.add(Icon(Icons.star, color: Colors.green[500]));
      else
        estrellas.add(Icon(Icons.star, color: Colors.black));
    }
    return Row(
      children: [
        estrellas[0],
        estrellas[1],
        estrellas[2],
        estrellas[3],
        estrellas[4],
      ],
    );
  }


  static getIconDatos(Icon icono, String descri){
    return  Card(
      child: Row(
          children: [
            icono,
            Text("  "),
            Text(descri),
          ],
          
      )
    );
  }
}