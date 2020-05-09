import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/model/FormaPagamento.dart';
import 'package:projeto_pdm/services/FormaPagamentoService.dart';

import 'Editor.dart';

class FormularioFormaPagamento extends StatefulWidget {
  final FormaPagamento _formaPagamento;
  FormularioFormaPagamento(this._formaPagamento);

  @override
  _FormularioFormaPagamentoState createState() =>
      _FormularioFormaPagamentoState();
}

class _FormularioFormaPagamentoState extends State<FormularioFormaPagamento> {
  final db = Firestore.instance;

  TextEditingController _ctrlDescricao = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ctrlDescricao =
        TextEditingController(text: widget._formaPagamento.descricao);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastar froma de pagamento"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Editor(
                _ctrlDescricao, "Descrição", "Insira a forma de pagamento"),
          ),
          RaisedButton(
            onPressed: () {
              if (widget._formaPagamento.id != null) {
                FormaPagamentoService().setData(
                    {"descricao": _ctrlDescricao.text}, widget._formaPagamento);
                Navigator.pop(context);
              } else {
                FormaPagamentoService().setData(
                    {"descricao": _ctrlDescricao.text}, widget._formaPagamento);
                Navigator.pop(context);
              }
            },
            child: (widget._formaPagamento.id != null)
                ? Text("Atualizar")
                : Text("Adicionar"),
          ),
        ],
      ),
    );
  }
}
