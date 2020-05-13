class Consulta {
  String _id;
  String _data;
  String _paciente;
  String _pagamento;
  String _prescricao;
  String _requisicao;
  String _cobertura;
  String _medico;

  Consulta(this._id, this._data, this._cobertura, this._medico, this._paciente,
      this._pagamento, this._prescricao, this._requisicao);

  //ToMap e FromMap
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['data'] = _data;
    map['paciente'] = _paciente;
    map['pagamento'] = _pagamento;
    map['prescricao'] = _prescricao;
    map['requisicao'] = _requisicao;
    map['cobertura'] = _cobertura;
    map['medico'] = _medico;

    return map;
  }

  Consulta.fromMap(Map<String, dynamic> map, String id) {
    this._id = id ?? '';
    _data = map['data'];
    _paciente = map['paciente'];
    _pagamento = map['pagamento'];
    _prescricao = map['prescricao'];
    _requisicao = map['requisicao'];
    _cobertura = map['cobertura'];
    _medico = map['medico'];
  }

  //Setters & Setters
  String get medico => _medico;

  set medico(String value) {
    _medico = value;
  }

  String get cobertura => _cobertura;

  set cobertura(String value) {
    _cobertura = value;
  } //Getters & Setters

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get data => _data;

  set data(String value) {
    _data = value;
  }

  String get paciente => _paciente;

  set paciente(String value) {
    _paciente = value;
  }

  String get pagamento => _pagamento;

  set pagamento(String value) {
    _pagamento = value;
  }

  String get prescricao => _prescricao;

  set prescricao(String value) {
    _prescricao = value;
  }

  String get requisicao => _requisicao;

  set requisicao(String value) {
    _requisicao = value;
  }
}
