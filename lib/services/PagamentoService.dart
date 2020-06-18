import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/formularios/FormFormaPagamento.dart';
import 'package:projeto_pdm/model/FormaPagamento.dart';

class PagamentoService {
  static final PagamentoService _pagamentoService =
      PagamentoService._internal();

  factory PagamentoService() {
    return _pagamentoService;
  }
  PagamentoService._internal();

  final db = Firestore.instance;

  Stream<QuerySnapshot> getListaPagamentos() {
    return Firestore.instance.collection("pagamentos").snapshots();
  }

  void excluirPagamento(BuildContext context, DocumentSnapshot doc,
      int position, Function setState, List lista) async {
    db.collection("formasPagamento").document(doc.documentID).delete();

    setState(() {
      lista.removeAt(position);
    });
  }

  void irParaPagamento(context, FormaPagamento formaPagamento) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormularioFormaPagamento(formaPagamento)));
  }

  void criarPagamento(
      BuildContext context, FormaPagamento formaPagamento) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                FormularioFormaPagamento(FormaPagamento(null, ""))));
    //setState(() {});
  }

  void setData(Map<String, dynamic> map, FormaPagamento formaPagamento) {
    db.collection("formasPagamento").document(formaPagamento.id).setData(map);
  }
}
