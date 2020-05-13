
class RequisicaoExame {
  String _id;
  String _data;
  String _descricao;

  RequisicaoExame(this._id,this._descricao,this._data);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) map['id'] = _id;
    map['descricao'] = _descricao;
    map['data'] = _data;
    
    return map;
  }

  RequisicaoExame.fromMap(Map<String, dynamic> map, String id) {
    this._id = id ?? '';
    _id = map['id'];
    _descricao = map['descricao'];
    _data = map['data'];
    //_consulta = map['consultas'];
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get dataRequisicao => _data;

  //String get consulta => _consulta;

  set data(String data) => this._data = data;

  //set consulta(Consulta consulta) => this._consulta = consulta;

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }
}
