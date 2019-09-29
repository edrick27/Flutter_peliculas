import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProviders {
  String _apiKey = '6328c41e2ae019e1de784ef57d253f79';
  String _url = 'api.themoviedb.org';
  String _lenguage = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {
    
    final url = Uri.https(_url, "3/movie/now_playing",{
      'api_key' : _apiKey,
      'lenguaje': _lenguage
    });

    final response = await http.get(url);
    final decodeData = json.decode(response.body);

    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
    
  }
}