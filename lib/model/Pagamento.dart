import 'Consulta.dart';
import 'FormaPagamento.dart';

class Pagamento {
  int _id;
  double _valor;
  DateTime _data;
  List<FormaPagamento> _formasPagamento;
  List<Consulta> _consultas;

Pagamento(this._id, this._valor, this._data, this._consultas, this._formasPagamento);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': _id,
      'valor': _valor,
      'data': _data,
      'formasPagamento': _formasPagamento,
      'consultas': _consultas
    };
    return map;
  }
  Pagamento.fromMap(Map<String, dynamic> map){
    _id = map['id'];
    _valor = map['valor'];
    _data = map['data'];
    _formasPagamento = map['formasPagamento'];
    _consultas = map['consultas'];
  }

//Getters & Setters
  set valor(double valor) => this._valor = valor;

  set id(int value) {
    _id = value;
  }

  set data(DateTime value) {
    _data = value;
  }

  set formasPagamento(List<FormaPagamento> value) {
    _formasPagamento = value;
  }

  set consultas(List<Consulta> value) {
    _consultas = value;
  }

  int get id => _id;

  double get valor => _valor;

  DateTime get data => _data;

  List get fomasPagamento => _formasPagamento;

  List get consulta => _consultas;

  List<Consulta> get consultas => _consultas;

  List<FormaPagamento> get formasPagamento => _formasPagamento;
}
