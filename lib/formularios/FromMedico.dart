import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_pdm/formularios/Editor.dart';
import 'package:projeto_pdm/model/Especialidade.dart';
import 'package:projeto_pdm/model/Medicos.dart';
import 'package:projeto_pdm/services/EspecialidadeService.dart';
import 'package:projeto_pdm/services/MedicoService.dart';

Especialidade valorDropDown;

class FormularioMedico extends StatefulWidget {
  final Medico medico;
  FormularioMedico(this.medico);
  @override
  _FormularioMedicoState createState() => _FormularioMedicoState();
}

class _FormularioMedicoState extends State<FormularioMedico> {
  TextEditingController _ctrlNome = TextEditingController();
  TextEditingController _ctrlCRM = TextEditingController();
  TextEditingController _ctrlTelefone = TextEditingController();
  var es;

  @override
  void initState(){
    super.initState();
    _ctrlCRM = TextEditingController(text: widget.medico.crm);
    _ctrlTelefone = TextEditingController(text: widget.medico.telefone);
    _ctrlNome = TextEditingController(text: widget.medico.nome);
    String espec = widget.medico.especialidade;

    
    if (espec != "" || espec != null) {
      es = StreamBuilder<DocumentSnapshot>(
        stream: EspecialidadeService().getEspecialidadePorId(espec),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          valorDropDown = Especialidade.fromMap(snapshot.data.data, snapshot.data.documentID);
        }
        );

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Médicos"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Editor(_ctrlNome, "Nome", "Insira o nome do médico"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Editor(_ctrlCRM, "CRM", "Insira o CRM"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Editor(
              _ctrlTelefone,
              "Telefone",
              "Insira o Telefone",
              teclado: TextInputType.phone,
            ),
          ),
          DropDownEspecialidades(),
          RaisedButton(
            onPressed: () {
              if (widget.medico.id != null) {
                MedicoService().setData({
                  "nome": _ctrlNome.text,
                  "crm": _ctrlCRM.text,
                  "telefone": _ctrlTelefone.text,
                  "especialidade": valorDropDown.id
                }, widget.medico);
                Navigator.pop(context);
              } else {
                MedicoService().setData({
                  "nome": _ctrlNome.text,
                  "crm": _ctrlCRM.text,
                  "telefone": _ctrlTelefone.text,
                  "especialidade": valorDropDown.id
                }, widget.medico);
                Navigator.pop(context);
              }
            },
            child: (widget.medico.id != null)
                ? Text("Atualizar")
                : Text("Adicionar"),
          ),
        ],
      ),
    );
  }
}

class DropDownEspecialidades extends StatefulWidget {
  @override
  _DropDownEspecialidadesState createState() => _DropDownEspecialidadesState();
}

class _DropDownEspecialidadesState extends State<DropDownEspecialidades> {
  List<Especialidade> especialidades = List();
  StreamSubscription<QuerySnapshot> cadastroEspecialidade;
  var db = Firestore.instance;
  static Especialidade dropdownValue;

  //Object dropdownValue = EspecialidadeService().listarEspecialidades().first;
  @override
  void initState() {
    super.initState();

    especialidades = List();
    cadastroEspecialidade?.cancel();

    cadastroEspecialidade =
        db.collection("especialidades").snapshots().listen((snapshot) {
      final List<Especialidade> especialidades = snapshot.documents
          .map(
            (documentSnapshot) => Especialidade.fromMap(
                documentSnapshot.data, documentSnapshot.documentID),
          )
          .toList();

      setState(() {
        this.especialidades = especialidades;
      });
      dropdownValue = valorDropDown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        value: dropdownValue,
        items: especialidades.map((Especialidade especialidade) {
          return new DropdownMenuItem<Especialidade>(
              value: especialidade, child: Text(especialidade.descricao));
        }).toList(),
        onChanged: (Especialidade value) {
          setState(() {
            valorDropDown = value;
            dropdownValue = value;
          });
        },
      ),
    );
  }
}
