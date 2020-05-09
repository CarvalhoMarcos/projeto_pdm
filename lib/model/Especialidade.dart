//import 'package:projeto_pdm/model/medicos.dart';

class Especialidade {
  String _id;
  String _descricao;
  //List<Medico> _medicos;

  Especialidade(this._id, this._descricao);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
      if(_id != null ){
        map['id'] =_id;
      }
      map['descricao'] = _descricao;
      //'medicos' : _medicos
    
    return map;

  }
  Especialidade.fromMap(Map<String, dynamic> map, String id){
    this._id = id ?? '';
    _descricao = map['descricao'];
    //_medicos = map['medicos'];
  }

  //Getters & Setters
  set id(String id) => this._id = id;

  set descricao(String descricao) => this._descricao = descricao;

  //set medicos(List<Medico> medicos) => this._medicos = medicos;

  String get id => this._id;

  String get descricao => this._descricao;
//List<Medico> get medicos => this._medicos;
}
