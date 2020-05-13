import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/formularios/FormConsulta.dart';
import 'package:projeto_pdm/model/Consulta.dart';
import 'package:projeto_pdm/services/ConsultaService.dart';

class ListaConsultas extends StatefulWidget {
  @override
  _ListaConsultasState createState() => _ListaConsultasState();
}

class _ListaConsultasState extends State<ListaConsultas> {
  var db = Firestore.instance;
  List<Consulta> consultas;

  StreamSubscription<QuerySnapshot> cadastroConsulta;

  @override
  void initState() {
    super.initState();

    consultas = List();
    cadastroConsulta?.cancel();

    cadastroConsulta = db.collection("consultas").snapshots().listen((snapshot) {
      final List<Consulta> consultas = snapshot.documents.map(
            (documentSnapshot) => Consulta.fromMap(documentSnapshot.data, documentSnapshot.documentID),
          ).toList();

      setState(() {
        this.consultas = consultas;
      });
    });
  }

    @override
  void dispose() {
    cadastroConsulta?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consultas"),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: ConsultaService().getListaConsultas(),
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
                            key: Key(consultas[index].data),
                            child: Card(
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: (Text(consultas[index].data)),
                                ),
                                onTap: () =>
                                    ConsultaService().irParaConsulta(context, consultas[index]),
                              ),
                            ),
                            background: Container(
                              color: Colors.red.withOpacity(0.8),
                            ),
                            onDismissed: (direction) {
                              ConsultaService().excluirConsulta(
                                  context, documentos[index], index, setState, consultas);
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
        onPressed: () => ConsultaService().criarConsulta(context,  Consulta(null, "","","","","","","")),
        child: Icon(Icons.add),
      ),
    );
  }
}