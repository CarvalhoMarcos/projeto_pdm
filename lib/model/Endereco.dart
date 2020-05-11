class Endereco {
  String _id;
  int _cep;
  int _numero;
  String _cidade;
  String _logradouro;
  String _estado;

  Endereco(this._id, this._cep, this._numero, this._cidade, this._estado,
      this._logradouro);

  //ToMap & FromMap
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['cep'] = _cep;
    map['numero'] = _numero;
    map['cidade'] = _cidade;
    map['logradouro'] = _logradouro;
    map['estado'] = _estado;

    return map;
  }

  Endereco.fromMap(Map<String, dynamic> map, String id) {
    this._id = id ?? '';
    _cep = map['cep'];
    _numero = map['numero'];
    _cidade = map['cidade'];
    _logradouro = map['logradouro'];
    _estado = map['estado'];
  }

  //Getters & Setters
  set cidade(String cidade) => this._cidade = cidade;
  set logradouro(String logradouro) => this._logradouro = logradouro;
  set cep(int cep) => this._cep = cep;
  set estado(String estado) => this._estado = estado;
  set numero(int numero) => this._numero = numero;
  set id(String id) => this._id = id;
  String get id => _id;
  int get numero => _numero;
  String get cidade => _cidade;
  String get logradouro => _logradouro;
  int get cep => _cep;
  String get estado => _estado;
}
