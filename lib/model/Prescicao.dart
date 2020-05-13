
class PrescricaoMedicamento {
  String _id;
  String _descricao;
  String _data;
  //Consulta _consulta;

PrescricaoMedicamento(this._id, this._descricao,this._data);

//ToMap & FromMap
  Map<String, dynamic> toMap() {
    var map = Map <String, dynamic>();
      if (_id != null) map['id'] = _id;
      map['descricao'] = _descricao;
      map['data']=  _data;
      //'consultas': _consulta
    return map;
  }
  PrescricaoMedicamento.fromMap(Map<String, dynamic> map, String id){
     this._id = id ?? '';
    _descricao = map['descricao'];
    _data = map['data'];
    //_consulta = map['consultas'];
  }


//Getters & Setters
  String get id => _id;

  set id(String value) {
    _id = value;
  }

  //Consulta get consulta => _consulta;

  String get medicamento => _descricao;

  set medicamento(String medicamento) => this._descricao = medicamento;

  //set consulta(Consulta consulta) => this._consulta = consulta;

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  String get data => _data;

  set data(String value) {
    _data = value;
  }
}
