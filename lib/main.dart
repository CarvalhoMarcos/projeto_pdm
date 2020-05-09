import 'package:flutter/material.dart';
import 'package:projeto_pdm/pages/pageInicial.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevCLin',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: PaginaInicial(),
    );
  }
}
