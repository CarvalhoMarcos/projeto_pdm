//import 'package:projeto_pdm/model/Pagamento.dart';

class FormaPagamento {
  String _id;
  String _descricao;
  //List<Pagamento> _pagamentos;

  FormaPagamento(this._id, this._descricao);
  //ToMap & FromMap
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['descricao'] = _descricao;
    //map['pagamentos'] = _pagamentos;

    return map;
  }

  FormaPagamento.fromMap(Map<String, dynamic> map, String id) {
    this._id = id ?? '';
    _descricao = map['descricao'];
    //_pagamentos = map['pagamentos'];
  }

  //Getters & Setters
  String get id => _id;
  set id(String value) {
    _id = value;
  }

  String get descricao => _descricao;
  set descricao(String descricao) => this._descricao = descricao;
/*
  get pagamentos => _pagamentos;

  set pagamentos(List<Pagamento> value) {
    _pagamentos = value;
  }
  */
}
