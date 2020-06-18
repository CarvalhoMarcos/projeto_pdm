import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/formularios/Editor.dart';
import 'package:projeto_pdm/model/Consulta.dart';
import 'package:projeto_pdm/model/Medicos.dart';
import 'package:projeto_pdm/model/Paciente.dart';
import 'package:projeto_pdm/model/Prescicao.dart';
import 'package:projeto_pdm/model/RequisicaoExame.dart';
import 'package:projeto_pdm/services/CoberturaService.dart';
import 'package:projeto_pdm/services/ConsultaService.dart';
import 'package:projeto_pdm/services/FormaPagamentoService.dart';
import 'package:projeto_pdm/services/MedicoService.dart';
import 'package:projeto_pdm/services/PacienteService.dart';
import 'package:projeto_pdm/services/ReceitaService.dart';
import 'package:projeto_pdm/services/RequisicaoService.dart';

String dropdownPacienteValue;
String dropdownMedicoValue;
String dropdownCoberturaValue;
String dropdownFormaPagamentoValue;

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
  String _formaPagamentoSelecionada;

  DateTime _dataAtual = new DateTime.now();

  TextEditingController _ctrlReceita = TextEditingController();
  TextEditingController _ctrlRequisicao = TextEditingController();
  static TextEditingController _ctrlValor = TextEditingController();

  RequisicaoExame exame;
  PrescricaoMedicamento prescicao;
  Medico medico;
  Paciente paciente;

  var _valor = Editor(_ctrlValor, "Valor", "0.00", teclado: TextInputType.number);

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
      dropdownFormaPagamentoValue = widget._consulta.pagamento;
    } else {
      dropdownPacienteValue = null;
      dropdownMedicoValue = null;
      dropdownCoberturaValue = null;
      dropdownFormaPagamentoValue = null;
    }
  }
  var listViewItens;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro da consulta")),
      body: ListView(
        children:  listViewItens = <Widget>[
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                        hint: Text("Selecione o paciente"),
                        isExpanded: true,
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
                      ),
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                        hint: Text("Selecione o Médico"),
                        isExpanded: true,
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
                      ),
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                        hint: Text("Selecione a Cobertura"),
                        isExpanded: true,
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
                      ),
                    );
                }
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Editor(_ctrlReceita, "Receita", "Insira a receita"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Editor(
                _ctrlRequisicao, "Requisição de exame", "Insira a requisção"),
          ),
          StreamBuilder(
              stream: FormaPagamentoService().getListaFormasPagamento(),
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
                    List<DocumentSnapshot> docFormaPagametnos =
                        snapshot.data.documents;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                        hint: Text("Selecione a Forma de pagamento"),
                        isExpanded: true,
                        value: dropdownFormaPagamentoValue,
                        items: docFormaPagametnos.map((DocumentSnapshot doc) {
                          return DropdownMenuItem<String>(
                              value: doc.documentID,
                              child: Text(doc.data['descricao'].toString()));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropdownFormaPagamentoValue = value;
                            _formaPagamentoSelecionada = value;                            
                            print(_formaPagamentoSelecionada);
                          });
                        },
                      ),
                    );
                }
              }),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
            child: RaisedButton(
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
                      "requisicao": exame,
                      "pagamento": _formaPagamentoSelecionada
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
                      "requisicao": exame,
                      "pagamento": _formaPagamentoSelecionada
                    }, widget._consulta);

                    Navigator.pop(context);
                  }
                }),
          ),
        ],
      ),
    );
  }
}
