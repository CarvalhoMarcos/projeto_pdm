import 'package:projeto_pdm/model/Consulta.dart';
import 'package:projeto_pdm/model/especialidade.dart';

class Medico {
  int _id;
  String _nome;
  String _crm;
  String _telefone;
  Especialidade _especialidade;
  //List<Consulta> _consultas;
  
  Medico(this._id, this._nome, this._crm, this._telefone,this._especialidade);
  
  //ToMap & FromMap
    Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'id': _id,
      'nome' : _nome,
      'crm' : _crm,
      'telefone' : _telefone,
      'especialidade' : _especialidade
    };
    return map;
  }

  Medico.fromMap(Map<String,dynamic> map){
    _id = map['id'];
    _nome = map['nome'];
    _crm = map['crm'];
    _telefone = map['telefone'];
    _especialidade = map['especialidade'];
  }


//Getters & Setters
  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get nome => this._nome;

  String get crm => this._crm;

  String get telefone => this._telefone;

  Especialidade get especialidade => this._especialidade;

  set especialidade(Especialidade especialidade) =>
      this._especialidade = especialidade;

  set crm(String crm) => this._crm = crm;

  set nome(String nome) => this._nome = nome;

  set telefone(String telefone) => this._telefone = telefone;
/*
  List<Consulta> get consultas => _consultas;

  set consultas(List<Consulta> value) {
    _consultas = value;
  }
*/
}
