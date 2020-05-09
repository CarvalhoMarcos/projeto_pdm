import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/model/FormaPagamento.dart';

import 'Editor.dart';

class FormularioFormaPagamento extends StatefulWidget {
  final FormaPagamento _formaPagamento;
  FormularioFormaPagamento(this._formaPagamento);

  @override
  _FormularioFormaPagamentoState createState() => _FormularioFormaPagamentoState();
}

class _FormularioFormaPagamentoState extends State<FormularioFormaPagamento> {
  final db = Firestore.instance;

  TextEditingController _ctrlDescricao = TextEditingController();
  
  @override
  void initState(){
    super.initState();
    _ctrlDescricao = TextEditingController(text: widget._formaPagamento.descricao);
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
            child: Editor(_ctrlDescricao, "Descrição", "Insira a forma de pagamento"),
          ),
          RaisedButton(
            
            onPressed: () {
              
              if(widget._formaPagamento.id != null){
                db.collection("formasPagamento").document(widget._formaPagamento.id)
                .setData({
                  "descricao" : _ctrlDescricao.text
                });
                Navigator.pop(context);
              }else{
                db.collection("formasPagamento").document(widget._formaPagamento.id)
                .setData({
                  "descricao" : _ctrlDescricao.text
                });
                Navigator.pop(context);
              }
            },
            child: (widget._formaPagamento.id != null) ? Text("Atualizar") : Text("Adicionar"),
          ),
        ],
      ),
    );
  }
}