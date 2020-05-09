import 'package:projeto_pdm/model/consulta.dart';
import 'package:projeto_pdm/model/endereco.dart';

class Paciente {
  String _nome;
  String _sexo;
  String _cpf;
  String _rg;
  DateTime _nascimento;
  Endereco _endereco;
  List<Consulta> _consultas;
  int _telefone;

  // Construtor
  Paciente(this._nome, this._sexo, this._cpf, this._rg, this._nascimento,
      this._endereco, this._consultas, this._telefone);
  // Map e toMap
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'cpf': _cpf,
      'rg': _rg,
      'nome': _nome,
      'telefone': _telefone,
      'sexo': _sexo,
      'endereco': _endereco,
      'nascimento': _nascimento,
      'consultas': _consultas
    };
    return map;
  }
  Paciente.fromMap(Map<String, dynamic> map){
    _cpf = map['cpf'];
    _rg = map['rg'];
    _nome = map['nome'];
    _telefone = map['telefone'];
    _sexo = map['sexo'];
    _endereco = map['endereco'];
    _nascimento = map['nascimento'];
    _consultas = map['consultas'];
  }
  //Getters & Setters
  set telefone(int telefone) => this._telefone = telefone;

  set cpf(String cpf) => this._cpf = cpf;

  set rg(String rg) => this._rg = rg;

  set nome(String nome) => this._nome = nome;

  set sexo(String sexo) => this._sexo = sexo;

  set nascimento(DateTime nascimento) => this._nascimento = nascimento;

  set endereco(Endereco endereco) => this._endereco = endereco;

  set consultas(List<Consulta> consultas) => this._consultas = consultas;

  int get telefone => _telefone;

  String get cpf => _cpf;

  String get rg => _rg;

  Endereco get endereco => _endereco;

  DateTime get nascimento => _nascimento;

  String get nome => _nome;

  String get sexo => _sexo;

  List<Consulta> get consultas => _consultas;

}
