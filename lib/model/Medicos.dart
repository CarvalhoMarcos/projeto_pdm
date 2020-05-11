
class Medico {
  String _id;
  String _nome;
  String _crm;
  String _telefone;
  String _idEspecialidade;
  //List<Consulta> _consultas;
  
  Medico(this._id, this._nome, this._crm, this._telefone,this._idEspecialidade);
  
  //ToMap & FromMap
    Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
      if(_id != null ){
        map['id'] =_id;
      }
      map['nome'] = _nome;
      map['crm'] = _crm;
      map['telefone'] = _telefone;
      map['especialidade'] = _idEspecialidade;
    
    return map;
  }

  Medico.fromMap(Map<String,dynamic> map, String id){
    this._id = id ?? '';
    _nome = map['nome'];
    _crm = map['crm'];
    _telefone = map['telefone'];
    _idEspecialidade = map['especialidade'];
  }


//Getters & Setters
  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get nome => this._nome;

  String get crm => this._crm;

  String get telefone => this._telefone;

  String get especialidade => this._idEspecialidade;

  set especialidade(String especialidade) =>
      this._idEspecialidade = especialidade;

  set crm(String crm) => this._crm = crm;

  set nome(String nome) => this._nome = nome;

  set telefone(String telefone) => this._telefone = telefone;
/*
  List<Consulta> get consultas => _consultas;

  set consultas(List<Consulta> value) {
    _consultas = value;
  }
*/
}
