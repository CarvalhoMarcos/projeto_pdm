
import 'package:projeto_pdm/model/Cobertura.dart';
import 'package:projeto_pdm/model/Medicos.dart';
import 'package:projeto_pdm/model/Paciente.dart';
import 'package:projeto_pdm/model/Pagamento.dart';
import 'package:projeto_pdm/model/Prescicao.dart';
import 'package:projeto_pdm/model/RequisicaoExame.dart';

class Consulta {
  int _id;
  DateTime _data;
  Paciente _paciente;
  List<Pagamento> _pagamentos;
  List<PrescricaoMedicamento> _prescricoes;
  List<RequisicaoExame> _requisicoes;
  Cobertura _cobertura;
  Medico _medico;

  Consulta(this._id, this._data, this._cobertura, this._medico, 
           this._paciente, this._pagamentos, this._prescricoes, 
           this._requisicoes);

  //ToMap e FromMap
    Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'id': _id,
      'data' : _data,
      'paciente' : _paciente,
      'pagamentos' : _pagamentos,
      'prescricoes' : _prescricoes,
      'requisicoes' : _requisicoes,
      'cobertura' : _cobertura,
      'medico' : _medico
    };
    return map;
  }

  Consulta.fromMap(Map<String,dynamic> map){
    _id = map['id'];
    _data = map['data'];
    _paciente = map['paciente'];
    _pagamentos = map['pagamentos'];
    _prescricoes = map['prescricoes'];
    _requisicoes = map['requisicoes'];
    _cobertura = map['cobertura'];
    _medico = map['medico'];
  }

  //Setters & Setters
  Medico get medico => _medico;

  set medico(Medico value) {
    _medico = value;
  }

  Cobertura get cobertura => _cobertura;

  set cobertura(Cobertura value) {
    _cobertura = value;
  } //Getters & Setters

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  DateTime get data => _data;

  set data(DateTime value) {
    _data = value;
  }

  Paciente get paciente => _paciente;

  set paciente(Paciente value) {
    _paciente = value;
  }

  List<Pagamento> get pagamentos => _pagamentos;

  set pagamentos(List<Pagamento> value) {
    _pagamentos = value;
  }

  List<PrescricaoMedicamento> get prescricoes => _prescricoes;

  set prescricoes(List<PrescricaoMedicamento> value) {
    _prescricoes = value;
  }

  List<RequisicaoExame> get requisicoes => _requisicoes;

  set requisicoes(List<RequisicaoExame> value) {
    _requisicoes = value;
  }
}
