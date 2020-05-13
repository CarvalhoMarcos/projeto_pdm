import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/formularios/FormConsulta.dart';
import 'package:projeto_pdm/model/Consulta.dart';
import 'package:projeto_pdm/model/Prescicao.dart';
import 'package:projeto_pdm/model/RequisicaoExame.dart';
import 'package:projeto_pdm/services/ReceitaService.dart';
import 'package:projeto_pdm/services/RequisicaoService.dart';

class ConsultaService{
 static final ConsultaService _consultaService =
      ConsultaService._internal();

  factory ConsultaService() {
    return _consultaService;
  }
  ConsultaService._internal();

  final db = Firestore.instance;

    void irParaConsulta(context, Consulta consulta) async {
      RequisicaoExame exame = await RequisicaoService().getRquisicaoPorId(consulta.requisicao);
      PrescricaoMedicamento receita = await ReceitaService().getReceitaPorId(consulta.prescricao);
    await Navigator.push(context,MaterialPageRoute(
            builder: (context) => FormularioConsulta(consulta, exame, receita)));
  }
    void excluirConsulta(BuildContext context, DocumentSnapshot doc, int position, Function setState, List coberturas) async {
      db.collection("consultas").document(doc.documentID).delete();

      setState(() {
        coberturas.removeAt(position);
      });
  }
    Stream<QuerySnapshot> getListaConsultas() {
    return Firestore.instance.collection("consultas").snapshots();
  }

    void criarConsulta(BuildContext context, Consulta consulta) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormularioConsulta(Consulta(null, "","","","","","",""), 
            RequisicaoExame(null,"",""),
            PrescricaoMedicamento(null, "", ""))));
    //setState(() {});
  }
  
  void setData(Map<String, dynamic> map, Consulta consulta){
    db.collection("consultas").document(consulta.id).setData(map);
  }
}