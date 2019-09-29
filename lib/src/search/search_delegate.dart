import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearh extends SearchDelegate{

  String seleccion = '';
  final peliculasProvider = PeliculasProviders();

  final peliculas = [
    "SpiderMan",
    "Capitana Marvel",
    "Iroman",
    "Shazaam"
  ];

  final peliculasRecientes = [
    "infinity War",
    "Capitana Marvel",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // las acciones de nuestro appBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Es el icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 200.0,
        width: 100.0,
        color: Colors.indigoAccent,
        child: Text(seleccion),
      ),
    );
  }


   @override
  Widget buildSuggestions(BuildContext context) {
    // sugerencias que aparecen cuando las personas escriben

    if( query.isEmpty ){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){

          final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map((pelicula){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage("assets/img/loading.gif"),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueId = pelicula.id.toString();
                  Navigator.pushNamed(context, "detalle", arguments: pelicula);
                },
              );
            }).toList()
          ); 
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // sugerencias que aparecen cuando las personas escriben

  //   final listaSugerida = (query.isEmpty) 
  //                         ? peliculasRecientes 
  //                         : peliculas.where(
  //                           (p) => p.toLowerCase().startsWith(query.toLowerCase())
  //                         ).toList();

  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (context, i){
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[i]),
  //         onTap: (){
  //           seleccion = listaSugerida[i];
  //           showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }

}