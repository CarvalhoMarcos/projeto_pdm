import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/model/Cobertura.dart';
import 'package:projeto_pdm/services/CoberturaService.dart';

class ListaCoberturas extends StatefulWidget {
  @override
  _ListaCoberturasState createState() => _ListaCoberturasState();
}

class _ListaCoberturasState extends State<ListaCoberturas> {
  var db = Firestore.instance;
  List<Cobertura> coberturas;

  StreamSubscription<QuerySnapshot> cadastroCobertura;

  @override
  void initState() {
    super.initState();

    coberturas = List();
    cadastroCobertura?.cancel();

    cadastroCobertura = db.collection("coberturas").snapshots().listen((snapshot) {
      final List<Cobertura> coberturas = snapshot.documents.map(
            (documentSnapshot) => Cobertura.fromMap(documentSnapshot.data, documentSnapshot.documentID),
          ).toList();

      setState(() {
        this.coberturas = coberturas;
      });
    });
  }

  @override
  void dispose() {
    cadastroCobertura?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coberturas"),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: CoberturaService().getListaCoberturas(),
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
                            key: Key(coberturas[index].descricao),
                            child: Card(
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: (Text(coberturas[index].descricao)),
                                ),
                                onTap: () =>
                                    CoberturaService().irParaCbertura(context, coberturas[index]),
                              ),
                            ),
                            background: Container(
                              color: Colors.red.withOpacity(0.8),
                            ),
                            onDismissed: (direction) {
                              CoberturaService().excluirCobertura(
                                  context, documentos[index], index, setState, coberturas);
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
        onPressed: () => CoberturaService().criarCobertura(context, Cobertura(null, "")),
        child: Icon(Icons.add),
      ),
    );
  }

}
