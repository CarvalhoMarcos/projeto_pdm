import 'package:projeto_pdm/model/consulta.dart';

class PrescricaoMedicamento {
  int _id;
  String _descricao;
  DateTime _data;
  Consulta _consulta;

PrescricaoMedicamento(this._id, this._descricao,this._data,this._consulta);

//ToMap & FromMap
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': _id,
      'descricao': _descricao,
      'data': _data,
      'consultas': _consulta
    };
    return map;
  }
  PrescricaoMedicamento.fromMap(Map<String, dynamic> map){
    _id = map['id'];
    _descricao = map['descricao'];
    _data = map['data'];
    _consulta = map['consultas'];
  }


//Getters & Setters
  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Consulta get consulta => _consulta;

  String get medicamento => _descricao;

  set medicamento(String medicamento) => this._descricao = medicamento;

  set consulta(Consulta consulta) => this._consulta = consulta;

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  DateTime get data => _data;

  set data(DateTime value) {
    _data = value;
  }
}
