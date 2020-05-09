class Endereco {
  int _cep;
  String _cidade;
  String _logradouro;
  String _estado;

  Endereco(this._cep,this._cidade,this._estado,this._logradouro);

  //ToMap & FromMap
    Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'cep': _cep,
      'cidade' : _cidade,
      'logradouro' : _logradouro,
      'estado' : _estado
    };
    return map;
  }

  Endereco.fromMap(Map<String,dynamic> map){
    _cep = map['cep'];
    _cidade = map['cidade'];
    _logradouro = map['logradouro'];
    _estado = map['estado'];
  }

  //Getters & Setters
  set cidade(String cidade) => this._cidade = cidade;
  set logradouro(String logradouro) => this._logradouro = logradouro;
  set cep(int cep) => this._cep = cep;
  set estado(String estado) => this._estado = estado;
  String get cidade => _cidade;
  String get logradouro => _logradouro;
  int get cep => _cep;
  String get estado => _estado;
}
