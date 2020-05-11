class Paciente {
  String _cpf;
  String _nome;
  String _sexo;
  String _rg;
  String _nascimento;
  String _endereco;
  //List<Consulta> _consultas;
  int _telefone;

  // Construtor
  Paciente(this._cpf, this._nome,  this._rg, this._endereco, this._nascimento,
       this._telefone);
  // Map e toMap
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_cpf != null) {
      map['cpf'] = _cpf;
    }
    map['rg'] = _rg;
    map['nome'] = _nome;
    map['telefone'] = _telefone;
    map['endereco'] = _endereco;
    map['nascimento'] = _nascimento;

    return map;
  }

  Paciente.fromMap(Map<String, dynamic> map, String cpf) {
    this._cpf = cpf ?? '';
    _rg = map['rg'];
    _nome = map['nome'];
    _telefone = map['telefone'];
    _endereco = map['endereco'];
    _nascimento = map['nascimento'];
  }
  //Getters & Setters
  set telefone(int telefone) => this._telefone = telefone;

  set cpf(String cpf) => this._cpf = cpf;

  set rg(String rg) => this._rg = rg;

  set nome(String nome) => this._nome = nome;

  set sexo(String sexo) => this._sexo = sexo;

  set nascimento(String nascimento) => this._nascimento = nascimento;

  set endereco(String endereco) => this._endereco = endereco;

  //set consultas(List<Consulta> consultas) => this._consultas = consultas;

  int get telefone => _telefone;

  String get cpf => _cpf;

  String get rg => _rg;

  String get endereco => _endereco;

  String get nascimento => _nascimento;

  String get nome => _nome;

  String get sexo => _sexo;

  //List<Consulta> get consultas => _consultas;

}
