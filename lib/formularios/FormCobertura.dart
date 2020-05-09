import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/formularios/Editor.dart';
import 'package:projeto_pdm/model/Cobertura.dart';

class FormularioCobertura extends StatefulWidget {
  final Cobertura cobertura;
  FormularioCobertura(this.cobertura);

  @override
  _FormularioCoberturaState createState() => _FormularioCoberturaState();
}

class _FormularioCoberturaState extends State<FormularioCobertura> {
  final db = Firestore.instance;

  TextEditingController _ctrlDescricao = TextEditingController();
  
  @override
  void initState(){
    super.initState();
    _ctrlDescricao = TextEditingController(text: widget.cobertura.descricao);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Coberturas"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Editor(_ctrlDescricao, "Descrição", "Insira o nome do plano"),
          ),
          RaisedButton(
            
            onPressed: () {
              
              if(widget.cobertura.id != null){
                db.collection("coberturas").document(widget.cobertura.id)
                .setData({
                  "descricao" : _ctrlDescricao.text
                });
                Navigator.pop(context);
              }else{
                db.collection("coberturas").document(widget.cobertura.id)
                .setData({
                  "descricao" : _ctrlDescricao.text
                });
                Navigator.pop(context);
              }
            },
            child: (widget.cobertura.id != null) ? Text("Atualizar") : Text("Adicionar"),
          ),
        ],
      ),
    );
  }

}