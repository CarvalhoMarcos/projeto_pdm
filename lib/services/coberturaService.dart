import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/model/Cobertura.dart';

class CoberturaService {
  static final CoberturaService _coberturaService =
      CoberturaService._internal();

  factory CoberturaService() {
    return _coberturaService;
  }
  CoberturaService._internal();

  static var db = Firestore.instance;
  List<Cobertura> coberturas;
  StreamSubscription<QuerySnapshot> cadastroCobertura;

 Stream<QuerySnapshot> getListaCoberturas() {
    return Firestore.instance.collection("coberturas").snapshots();
  }

  static void excluirCobertura(
      BuildContext context, DocumentSnapshot doc, int position) async {
    db.collection("coberturas").document(doc.documentID).delete();

  }
   criarProduto(){
     print("bosta");
  }


}
