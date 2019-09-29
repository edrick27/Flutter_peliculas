import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProviders {
  String _apiKey = '6328c41e2ae019e1de784ef57d253f79';
  String _url = 'api.themoviedb.org';
  String _lenguage = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }

 Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    
    final response = await http.get(url);
    final decodeData = json.decode(response.body);

    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
 }

  Future<List<Pelicula>> getEnCines() async {
    
    final url = Uri.https(_url, "3/movie/now_playing",{
      'api_key' : _apiKey,
      'lenguaje': _lenguage
    });

    return await _procesarRespuesta(url);
  }

   Future<List<Pelicula>> getPopulares() async {

     if(_cargando) return [];

     _cargando = true;
     _popularesPage++;
    
    final url = Uri.https(_url, "3/movie/popular",{
      'api_key' : _apiKey,
      'lenguaje': _lenguage,
      'page': _popularesPage.toString()
    });

    final respuesta = await _procesarRespuesta(url);

    _populares.addAll(respuesta);

    popularesSink( _populares );

     _cargando = false;

    return respuesta;
  }

  Future<List<Actor>> getCast(String peliId) async {
    
    final url = Uri.https(_url, "3/movie/$peliId/credits",{
      'api_key' : _apiKey,
      'lenguaje': _lenguage
    });

    final response = await http.get(url);
    final decodeData = json.decode(response.body);

    final cast = new Cast.fromJsonList(decodeData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    
    final url = Uri.https(_url, "3/search/movie",{
      'api_key' : _apiKey,
      'lenguaje': _lenguage,
      'query'   : query,
    });

    return await _procesarRespuesta(url);
  }

}