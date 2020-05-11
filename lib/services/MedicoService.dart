import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/formularios/FromMedico.dart';
import 'package:projeto_pdm/model/Especialidade.dart';
import 'package:projeto_pdm/model/Medicos.dart';

class MedicoService{
    static final MedicoService _medicoService =
      MedicoService._internal();

  factory MedicoService() {
    return _medicoService;
  }
  MedicoService._internal();

  final db = Firestore.instance;

  void irParaMedico(context, Medico medico) async {
    await Navigator.push(context,MaterialPageRoute(
            builder: (context) => FormularioMedico(medico)));
  }
    void excluirMedico(BuildContext context, DocumentSnapshot doc, int position, Function setState, List coberturas) async {
      db.collection("medicos").document(doc.documentID).delete();

      setState(() {
        coberturas.removeAt(position);
      });
  }
    Stream<QuerySnapshot> getListaMedicos() {
    return Firestore.instance.collection("medicos").snapshots();
  }

    void criarMedico(BuildContext context, Medico medico) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormularioMedico(Medico(null, "","","", null))));
    //setState(() {});
  }
  
  void setData(Map<String, dynamic> map, Medico medico){
    db.collection("medicos").document(medico.id).setData(map);
  }

}