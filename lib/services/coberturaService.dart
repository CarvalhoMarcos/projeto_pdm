import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/formularios/FormCobertura.dart';
import 'package:projeto_pdm/model/Cobertura.dart';

class CoberturaService {
  static final CoberturaService _coberturaService =
      CoberturaService._internal();

  factory CoberturaService() {
    return _coberturaService;
  }
  CoberturaService._internal();
  final db = Firestore.instance;


  void irParaCbertura(context, Cobertura cobertura) async {
    await Navigator.push(context,MaterialPageRoute(
            builder: (context) => FormularioCobertura(cobertura)));
  }
    void excluirCobertura(BuildContext context, DocumentSnapshot doc, int position, Function setState, List coberturas) async {
      db.collection("coberturas").document(doc.documentID).delete();

      setState(() {
        coberturas.removeAt(position);
      });
  }
    Stream<QuerySnapshot> getListaCoberturas() {
    return Firestore.instance.collection("coberturas").snapshots();
  }

    void criarCobertura(BuildContext context, Cobertura cobertura) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormularioCobertura(Cobertura(null, ""))));
    //setState(() {});
  }
  
  void setData(Map<String, dynamic> map, Cobertura cobertura){
    db.collection("coberturas").document(cobertura.id).setData(map);
  }
  
}
