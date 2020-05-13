import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:projeto_pdm/formularios/FormPaciente.dart';
import 'package:projeto_pdm/model/Endereco.dart';

import 'package:projeto_pdm/model/Paciente.dart';
import 'package:projeto_pdm/services/EnderecoService.dart';

class PacienteService {
  static final PacienteService _pacienteService = PacienteService._internal();

  factory PacienteService() {
    return _pacienteService;
  }
  PacienteService._internal();

  final db = Firestore.instance;

  void irParaPaciente(context, Paciente paciente) async {
    Endereco endereco =
        await EnderecoService().getEnderecoPorId(paciente.endereco);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormularioPaciente(paciente, endereco)));
  }

  void excluirPaciente(BuildContext context, DocumentSnapshot doc, int position,
      Function setState, List pacientes) async {
    db.collection("pacientes").document(doc.documentID).delete();

    setState(() {
      pacientes.removeAt(position);
    });
  }

  Stream<QuerySnapshot> getListaPacientes() {
    return Firestore.instance.collection("pacientes").snapshots();
  }

  void criarPacientes(BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormularioPaciente(
                Paciente("", "", "", "", null, null), null)));
    //setState(() {});
  }

  void criarPaciente(Paciente paciente) {
    this.setData(paciente.toMap(), paciente);
  }

  void setData(Map<String, dynamic> map, Paciente paciente) {
    db.collection("pacientes").document(paciente.cpf).setData(map);
  }

  
}
