import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/formularios/FormFormaPagamento.dart';
import 'package:projeto_pdm/model/FormaPagamento.dart';

class FormaPagamentoService {
  static final FormaPagamentoService _formaPagamentoService =
      FormaPagamentoService._internal();

  factory FormaPagamentoService() {
    return _formaPagamentoService;
  }
  FormaPagamentoService._internal();

  final db = Firestore.instance;

  Stream<QuerySnapshot> getListaFormasPagamento() {
    return Firestore.instance.collection("formasPagamento").snapshots();
  }

  void excluirFormaPagamento(BuildContext context, DocumentSnapshot doc,
      int position, Function setState, List lista) async {
    db.collection("formasPagamento").document(doc.documentID).delete();

    setState(() {
      lista.removeAt(position);
    });
  }

  void irParaFormaPagamento(context, FormaPagamento formaPagamento) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormularioFormaPagamento(formaPagamento)));
  }

  void criarFormaPagamento(
      BuildContext context, FormaPagamento formaPagamento) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                FormularioFormaPagamento(FormaPagamento(null, ""))));
    //setState(() {});
  }

  void setData(Map<String, dynamic> map, FormaPagamento formaPagamento) {
    db.collection("especialidades").document(formaPagamento.id).setData(map);
  }
}
