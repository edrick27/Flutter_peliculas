import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

import 'package:peliculas/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProviders();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("peliculas"),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search),
            onPressed: (){},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperTarjetas()
          ],
        ),
      )
    );
  }


  Widget _swiperTarjetas(){

    return FutureBuilder(
      future:  peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if (snapshot.hasData) {
          return CardSwiper( peliculas: snapshot.data );
        } else {
          return Container(
            padding: EdgeInsets.only( top: 200.0 ),
            child: Center(
              child: CircularProgressIndicator()
            ),
          );
        }

      },
    );
  }
}