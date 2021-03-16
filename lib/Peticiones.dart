import 'dart:convert';
import 'package:http/http.dart' as http;

class TraerDatos{


  static Future<List<dynamic>> getTodosServicios() async {  
    http.Response response = await http.get('https://topicos-web.herokuapp.com/api/trabajadores/todos');

    if(response.statusCode == 200){
      print('petición correcta');
      print(response.statusCode);

      final jsonData = jsonDecode(response.body);
      List<dynamic> mapDatos = jsonData;
      return mapDatos;
    }else{
      return null;
    }
  }

  static  Future<String> calificar(String calif, String ciEmple, String idServi) async {
    http.Response response = await http.post('http://192.168.56.1/busqueda_empleos/datos/actualizarCalificacion.php', body: {
      'calificacion': calif,
      'ciEmpleado': ciEmple,
      'idServicio': idServi
    });

    if(response.statusCode == 200){
      print("peticion correcta");
      return calif;
    }
    else{
      print("Error");
      return "";
    }
  }


  /**-------------------------Modificaciones------------------------ */
    static Future<dynamic> getServiciosAndLugares() async {
  
    http.Response response = await http.get('https://topicos-web.herokuapp.com/api/busqueda');

    if(response.statusCode == 200){
      print('petición correcta');

      final jsonData = jsonDecode(response.body);
      var mapDatos = jsonData;
      return mapDatos;
    }else{
      return null;
    }

  }

  static Future<List<String>> getServiciosM() async {
    var servi = await getServiciosAndLugares();
    List<dynamic> servicios = await servi['servicios'];
    List<String> listServicios = List<String>();
    for (var i = 0; i < servicios.length; i++) {
      listServicios.add(servicios[i]['nombre']);
    }
    return listServicios;
  }

  static Future<List<String>> getLugaresM() async {
    var lug = await getServiciosAndLugares();
    List<dynamic> lugares = await lug['lugares'];
    List<String> listLugares = List<String>();
    for (var i = 0; i < lugares.length; i++) {
      listLugares.add(lugares[i]['direccion']);
    }
    return listLugares;
  }


  static Future<List<dynamic>> buscarUsuarioM(String servicio, String ubicacion, String horario) async {
    http.Response response = await http.post('https://topicos-web.herokuapp.com/api/busqueda/servicios', body: {
      'servicio': servicio,
      'direccion': ubicacion,
      'turno': horario
    });

  if(response.statusCode == 200){
    print('petición correcta');
    print(response.statusCode);

    final jsonData = jsonDecode(response.body);
    return jsonData;
  }else{
    return null;
  }

}

 static Future<List<dynamic>> misDatos(id) async {
    http.Response response = await http.post('http://topicos-web.herokuapp.com/api/trabajador/perfil', body: {
      'id': id.toString()
    });

  if(response.statusCode == 200){
    print('petición correcta');
    print(response.statusCode);

    final jsonData = jsonDecode(response.body);
    List<dynamic> mapDatos = [jsonData];
    return mapDatos;
  }else{
    return null;
  }

}

static Future<List<String>> serviciosEjercidos(id) async {
    List<dynamic> listaMisDatos = await misDatos(id);
    List<dynamic> listaServicios = listaMisDatos[0]['servicios'];
    List<String> listaServi = List<String>();
    for (var i = 0; i < listaServicios.length; i++) {
      listaServi.add(listaServicios[i]['nombre']);
      
    }
    return listaServi;
}

static Future<List<dynamic>> getEmpleadosPorServicio(String servicio) async {
  http.Response response = await http.post('https://topicos-web.herokuapp.com/api/trabajadores/servicio', body: {
    'servicio': servicio,
  });

  if(response.statusCode == 200){
    print('petición correcta');
    print(response.statusCode);

    final jsonData = jsonDecode(response.body);
    return jsonData;
  }else{
    return null;
  }
}

static Future<Map<String, dynamic>> solictarServicio(idServicio, idTrabajador, descripcion, latitud, longitud) async {
    http.Response response = await http.post('https://topicos-web.herokuapp.com/api/solicitud', body: {
      'servicio_id': idServicio.toString(),
      'trabajador_id': idTrabajador.toString(),
      'descripcion': descripcion,
      'latitud': latitud.toString(),
      'longitud': longitud.toString()
    });

  if(response.statusCode == 200){
    print('petición correcta');
    print(response.statusCode);

    final jsonData = jsonDecode(response.body);
    print(jsonData);
    return jsonData;
  }else{
    return null;
  }

}

}