import 'package:flutter/material.dart';
import 'package:peliculas/src/routes/router.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Películas',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: getRoutes(),
    );
  }
}