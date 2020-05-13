import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/formularios/Editor.dart';
import 'package:projeto_pdm/model/Cobertura.dart';
import 'package:projeto_pdm/model/Consulta.dart';
import 'package:projeto_pdm/model/Medicos.dart';
import 'package:projeto_pdm/model/Paciente.dart';
import 'package:projeto_pdm/model/Prescicao.dart';
import 'package:projeto_pdm/model/RequisicaoExame.dart';
import 'package:projeto_pdm/services/CoberturaService.dart';
import 'package:projeto_pdm/services/ConsultaService.dart';
import 'package:projeto_pdm/services/MedicoService.dart';
import 'package:projeto_pdm/services/PacienteService.dart';
import 'package:projeto_pdm/services/ReceitaService.dart';
import 'package:projeto_pdm/services/RequisicaoService.dart';

String dropdownPacienteValue;
String dropdownMedicoValue;
String dropdownCoberturaValue;

class FormularioConsulta extends StatefulWidget {
  final Consulta _consulta;
  final RequisicaoExame _requisicaoExame;
  final PrescricaoMedicamento _prescricaoMedicamento;
  FormularioConsulta(
      this._consulta, this._requisicaoExame, this._prescricaoMedicamento);

  @override
  _FormularioConsultaState createState() => _FormularioConsultaState();
}

class _FormularioConsultaState extends State<FormularioConsulta> {
  final db = Firestore.instance;
  String _pacienteSelecionado;
  String _medicoSelecionado;
  String _coberturaSelecionada;

  DateTime _dataAtual = new DateTime.now();

  TextEditingController _ctrlReceita = TextEditingController();
  TextEditingController _ctrlRequisicao = TextEditingController();

  RequisicaoExame exame;
  PrescricaoMedicamento prescicao;
  Medico medico;
  Paciente paciente;

  @override
  void initState() {
    super.initState();
    _ctrlReceita =
        TextEditingController(text: widget._prescricaoMedicamento.descricao);
    _ctrlRequisicao =
        TextEditingController(text: widget._requisicaoExame.descricao);

        print(dropdownPacienteValue);
        print(dropdownMedicoValue);
        print(dropdownCoberturaValue);

    if (widget._consulta.id != null) {
      dropdownPacienteValue = widget._consulta.paciente;
      dropdownMedicoValue = widget._consulta.medico;
      dropdownCoberturaValue = widget._consulta.cobertura;
    }else{
      dropdownPacienteValue = null;
      dropdownMedicoValue = null;
      dropdownCoberturaValue =null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro da consulta")),
      body: ListView(
        children: <Widget>[
          StreamBuilder(
              stream: PacienteService().getListaPacientes(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');

                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    List<DocumentSnapshot> docPacientes =
                        snapshot.data.documents;
                    return DropdownButton(
                      value: dropdownPacienteValue,
                      items: docPacientes.map((DocumentSnapshot doc) {
                        return DropdownMenuItem<String>(
                            value: doc.documentID,
                            child: Text(doc.data['cpf'].toString() +
                                " - " +
                                doc.data['nome'].toString()));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownPacienteValue = value;
                          _pacienteSelecionado = value;
                          print(_pacienteSelecionado);
                        });
                      },
                    );
                }
              }),
          StreamBuilder(
              stream: MedicoService().getListaMedicos(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');

                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    List<DocumentSnapshot> docMedicos = snapshot.data.documents;
                    return DropdownButton(
                      value: dropdownMedicoValue,
                      items: docMedicos.map((DocumentSnapshot doc) {
                        return DropdownMenuItem<String>(
                            value: doc.documentID,
                            child: Text(doc.data['crm'].toString() +
                                " - " +
                                doc.data['nome'].toString()));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownMedicoValue = value;
                          _medicoSelecionado = value;
                          print(_medicoSelecionado);
                        });
                      },
                    );
                }
              }),
          StreamBuilder(
              stream: CoberturaService().getListaCoberturas(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');

                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    List<DocumentSnapshot> docCoberturas =
                        snapshot.data.documents;
                    return DropdownButton(
                      value: dropdownCoberturaValue,
                      items: docCoberturas.map((DocumentSnapshot doc) {
                        return DropdownMenuItem<String>(
                            value: doc.documentID,
                            child: Text(doc.data['descricao'].toString()));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownCoberturaValue = value;
                          _coberturaSelecionada = value;
                          print(_coberturaSelecionada);
                        });
                      },
                    );
                }
              }),
          Editor(_ctrlReceita, "Receita", "Insira a receita"),
          Editor(_ctrlRequisicao, "Requisição de exame", "Insira a requisção"),
          RaisedButton(
              child: Text("Finalizar Consulta"),
              onPressed: () async {
                if (widget._consulta.id != null) {
                  String rec = await ReceitaService().criarReceita(
                      PrescricaoMedicamento(
                          null, _ctrlReceita.text, _dataAtual.toString()));
                  String exame = await RequisicaoService().criarRquisicao(
                      RequisicaoExame(
                          null, _ctrlRequisicao.text, _dataAtual.toString()));
                  ConsultaService().setData({
                    "paciente": _pacienteSelecionado,
                    "medico": _medicoSelecionado,
                    "cobertura": _coberturaSelecionada,
                    "prescricao": rec,
                    "requisicao": exame
                  }, widget._consulta);

                  Navigator.pop(context);
                } else {
                  String rec = await ReceitaService().criarReceita(
                      PrescricaoMedicamento(
                          null, _ctrlReceita.text, _dataAtual.toString()));
                  String exame = await RequisicaoService().criarRquisicao(
                      RequisicaoExame(
                          null, _ctrlRequisicao.text, _dataAtual.toString()));
                  ConsultaService().setData({
                    "data": _dataAtual.toString(),
                    "paciente": _pacienteSelecionado,
                    "medico": _medicoSelecionado,
                    "cobertura": _coberturaSelecionada,
                    "prescricao": rec,
                    "requisicao": exame
                  }, widget._consulta);

                  Navigator.pop(context);
                }
              }),
        ],
      ),
    );
  }
}
