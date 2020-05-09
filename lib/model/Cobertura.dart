
class Cobertura{
  String _id;
  String _descricao;
  //List<Consulta> _consultas;

  Cobertura(this._id, this._descricao);


  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
      if(_id != null ){
        map['id'] =_id;
      }
      map['descricao'] = _descricao;
      //'consultas' : _consultas
    
    return map;
  }

  Cobertura.fromMap(Map<String,dynamic> map, String id){
    this._id = id ?? '';
    _descricao = map['descricao'];
   // _consultas = map['consultas'];
  }

  String get id => _id;
  String get descricao => _descricao;
  //List<Consulta> get consultas => _consultas;

  set id(String id) => this._id = id;
  set descricao(String descricao) =>this._descricao = descricao;
  //set consultas(List consultas) => this._consultas = consultas;
  

}