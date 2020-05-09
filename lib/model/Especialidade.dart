import 'package:projeto_pdm/model/medicos.dart';

class Especialidade {
  int _id;
  String _descricao;
  //List<Medico> _medicos;

  Especialidade(this._id, this._descricao);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': _id,
      'descricao': _descricao,
      //'medicos' : _medicos
    };
    return map;
  }
  Especialidade.fromMap(Map<String, dynamic> map){
    _id = map['id'];
    _descricao = map['descicao'];
    //_medicos = map['medicos'];
  }

  //Getters & Setters
  set id(int id) => this._id = id;

  set descricao(String descricao) => this._descricao = descricao;

  //set medicos(List<Medico> medicos) => this._medicos = medicos;

  int get id => this._id;

  String get descricao => this._descricao;
//List<Medico> get medicos => this._medicos;
}
