import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/formularios/Editor.dart';
import 'package:projeto_pdm/model/Endereco.dart';
import 'package:projeto_pdm/model/Paciente.dart';
import 'package:projeto_pdm/services/EnderecoService.dart';
import 'package:projeto_pdm/services/PacienteService.dart';

class FormularioPaciente extends StatefulWidget {
  Endereco _endereco;
  Paciente _paciente;
  FormularioPaciente(this._paciente, this._endereco);

  @override
  _FormularioPacienteState createState() => _FormularioPacienteState();
}

class _FormularioPacienteState extends State<FormularioPaciente> {
  var db = Firestore.instance;

  TextEditingController _ctrlCpf = TextEditingController();
  TextEditingController _ctrlRg = TextEditingController();
  TextEditingController _ctrlNome = TextEditingController();
  TextEditingController _ctrlNascimento = TextEditingController();
  TextEditingController _ctrlTelefone = TextEditingController();

  TextEditingController _ctrlRua = TextEditingController();
  TextEditingController _ctrlNumero = TextEditingController();
  TextEditingController _ctrlEstado = TextEditingController();
  TextEditingController _ctrlCidade = TextEditingController();
  TextEditingController _ctrlCep = TextEditingController();

  @override
  void initState() {
    super.initState();

    _ctrlCpf = TextEditingController(text: widget._paciente.cpf);
    _ctrlRg = TextEditingController(text: widget._paciente.rg);
    _ctrlNome = TextEditingController(text: widget._paciente.nome);
    if(widget._paciente.nascimento == null){
      _ctrlNascimento = TextEditingController(text: "  /  /    ");
    }else{
      _ctrlNascimento = TextEditingController(text: widget._paciente.telefone.toString());
    }
      if(widget._paciente.nascimento == null){
      _ctrlTelefone = TextEditingController(text: "");
    }else{
      _ctrlTelefone = TextEditingController(text: widget._paciente.telefone.toString());
    }
    

    if (widget._endereco != null) {
      _ctrlRua = TextEditingController(text: widget._endereco.logradouro);
      _ctrlNumero = TextEditingController(text: widget._endereco.numero.toString());
      _ctrlEstado = TextEditingController(text: widget._endereco.estado);
      _ctrlCidade = TextEditingController(text: widget._endereco.cidade);
      _ctrlCep = TextEditingController(text: widget._endereco.cep.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro do Paciente"),
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Editor(_ctrlNome, "Nome", "Nome"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Editor(_ctrlNascimento, "Data de Nascimento", "  /  /    "),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Editor(_ctrlCpf, "CPF", "000.000.000-00"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Editor(_ctrlRg, "RG", "0000000-0"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Editor(
            _ctrlTelefone,
            "Telefone",
            "999999999",
            teclado: TextInputType.phone,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Editor(_ctrlCep, "CEP", "00000-000"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Editor(_ctrlRua, "Rua", "Nome da rua"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Editor(_ctrlNumero, "Número", "Número"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Editor(_ctrlCidade, "Cidade", "Cidade"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Editor(_ctrlEstado, "Estado", "Estado"),
        ),
        RaisedButton(
            child: Text("Adicionar"),
            onPressed: () async {
              Endereco endereco = Endereco(
                  null,
                  int.parse(_ctrlCep.text),
                  int.parse(_ctrlNumero.text),
                  _ctrlCidade.text,
                  _ctrlEstado.text,
                  _ctrlRua.text);
              var idEnd = await EnderecoService().criarEndereco(endereco);
              Paciente paciente = Paciente(
                  _ctrlCpf.text,
                  _ctrlNome.text,
                  _ctrlRg.text,
                  idEnd,
                  _ctrlNascimento.text,
                  int.parse(_ctrlTelefone.text));

                  PacienteService().criarPaciente(paciente);

                  Navigator.pop(context);
              //PacienteService().criarPaciente(Paciente(_ctrlCpf,_ctrlNome,));
            }),
      ]),
    );
  }
}
