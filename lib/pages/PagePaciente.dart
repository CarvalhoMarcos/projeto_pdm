import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/model/Paciente.dart';
import 'package:projeto_pdm/services/PacienteService.dart';

class ListaPacientes extends StatefulWidget {
  @override
  _ListaPacientesState createState() => _ListaPacientesState();
}

class _ListaPacientesState extends State<ListaPacientes> {
    var db = Firestore.instance;
  List<Paciente> pacientes;
  

  StreamSubscription<QuerySnapshot> cadastroPaciente;

  @override
  void initState() {
    super.initState();

    pacientes = List();
    cadastroPaciente?.cancel();

    cadastroPaciente = db.collection("pacientes").snapshots().listen((snapshot) {
      final List<Paciente> pacientes = snapshot.documents.map(
            (documentSnapshot) => Paciente.fromMap(documentSnapshot.data, documentSnapshot.documentID),
          ).toList();

      setState(() {
        this.pacientes = pacientes;
      });
    });
  }

  @override
  void dispose() {
    cadastroPaciente?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pacientes"),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: PacienteService().getListaPacientes(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');

              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  List<DocumentSnapshot> documentos = snapshot.data.documents;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: documentos.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(pacientes[index].nome),
                            child: Card(
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: (Text(pacientes[index].nome)),
                                ),
                                onTap: () =>
                                    PacienteService().irParaPaciente(context, pacientes[index]),
                              ),
                            ),
                            background: Container(
                              color: Colors.red.withOpacity(0.8),
                            ),
                            onDismissed: (direction) {
                              PacienteService().excluirPaciente(
                                  context, documentos[index], index, setState, pacientes);
                            },
                          );
                        }),
                  );
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => PacienteService().criarPacientes(context),
        child: Icon(Icons.add),
      ),
    );
  }
}