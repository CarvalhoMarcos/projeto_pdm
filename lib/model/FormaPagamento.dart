import 'package:projeto_pdm/model/Pagamento.dart';

class FormaPagamento{
  int _id;
  String _descricao;
  List<Pagamento> _pagamentos;

FormaPagamento(this._id, this._descricao, this._pagamentos);
  //ToMap & FromMap
    Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'id': _id,
      'descricao' : _descricao,
      'pagamentos' : _pagamentos
      
    };
    return map;
  }

  FormaPagamento.fromMap(Map<String,dynamic> map){
    _id = map['id'];
    _descricao = map['descricao'];
    _pagamentos = map['pagamentos'];
  }

  //Getters & Setters
  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get descricao => _descricao;

  set descricao(String descricao) => this._descricao = descricao;

  get pagamentos => _pagamentos;

  set pagamentos(List<Pagamento> value) {
    _pagamentos = value;
  }

}