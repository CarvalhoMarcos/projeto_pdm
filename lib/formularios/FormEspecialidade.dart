import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/formularios/Editor.dart';
import 'package:projeto_pdm/model/Especialidade.dart';
import 'package:projeto_pdm/services/EspecialidadeService.dart';

class FormularioEspecialidade extends StatefulWidget {
  final Especialidade _especialidade;
  FormularioEspecialidade(this._especialidade);

  @override
  _FormularioEspecialidadeState createState() => _FormularioEspecialidadeState();
}

class _FormularioEspecialidadeState extends State<FormularioEspecialidade> {
  final db = Firestore.instance;

  TextEditingController _ctrlDescricao = TextEditingController();
  
  
  @override
  void initState(){
    super.initState();
    _ctrlDescricao = TextEditingController(text: widget._especialidade.descricao);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Especialidades"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Editor(_ctrlDescricao, "Descrição", "Insira o nome da Especialidade"),
          ),
          RaisedButton(
            onPressed: () {
              
              if(widget._especialidade.id != null){
                EspecialidadeService().setData({
                  "descricao" : _ctrlDescricao.text }, widget._especialidade );

                Navigator.pop(context);
              }else{
                EspecialidadeService().setData({
                  "descricao" : _ctrlDescricao.text }, widget._especialidade);

                Navigator.pop(context);
              }
            },
            child: (widget._especialidade.id != null) ? Text("Atualizar") : Text("Adicionar"),
          ),
        ],
      ),
    );
  }
}