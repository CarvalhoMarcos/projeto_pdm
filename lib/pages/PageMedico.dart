import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/model/Medicos.dart';
import 'package:projeto_pdm/services/MedicoService.dart';

class ListaMedicos extends StatefulWidget {
  @override
  _ListaMedicosState createState() => _ListaMedicosState();
}

class _ListaMedicosState extends State<ListaMedicos> {
  var db = Firestore.instance;
  List<Medico> medicos;
  final String meio = " - ";

  StreamSubscription<QuerySnapshot> cadastroMedicos;

  @override
  void initState() {
    super.initState();

    medicos = List();
    cadastroMedicos?.cancel();

    cadastroMedicos = db.collection("medicos").snapshots().listen((snapshot) {
      final List<Medico> medicos = snapshot.documents
          .map(
            (documentSnapshot) => Medico.fromMap(
                documentSnapshot.data, documentSnapshot.documentID),
          )
          .toList();

      setState(() {
        this.medicos = medicos;
      });
    });
  }

  @override
  void dispose() {
    cadastroMedicos?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Médicos"),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: MedicoService().getListaMedicos(),
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
                            key: Key(medicos[index].nome),
                            child: Card(
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: (Text(medicos[index].crm + meio + medicos[index].nome)),
                                ),
                                onTap: () => MedicoService()
                                    .irParaMedico(context, medicos[index]),
                              ),
                            ),
                            background: Container(
                              color: Colors.red.withOpacity(0.8),
                            ),
                            onDismissed: (direction) {
                              MedicoService().excluirMedico(context,
                                  documentos[index], index, setState, medicos);
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
        onPressed: () => MedicoService()
            .criarMedico(context, Medico(null, "", "", "", null)),
        child: Icon(Icons.add),
      ),
    );
  }
}
