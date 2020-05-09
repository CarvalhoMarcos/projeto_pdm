import 'package:projeto_pdm/model/consulta.dart';

class RequisicaoExame {
  int _id;
  DateTime _data;
  Consulta _consulta;
  String _descricao;

RequisicaoExame();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': _id,
      'descricao': _descricao,
      'data': _data,
      'consultas': _consulta
    };
    return map;
  }
  RequisicaoExame.fromMap(Map<String, dynamic> map){
    _id = map['id'];
    _descricao = map['descricao'];
    _data = map['data'];
    _consulta = map['consultas'];
  }


  int get id => _id;

  set id(int value) {
    _id = value;
  }

  DateTime get dataRequisicao => _data;

  Consulta get consulta => _consulta;

  set data(DateTime data) =>
      this._data = data;

  set consulta(Consulta consulta) => this._consulta = consulta;

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }
}
