import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/formularios/FormCobertura.dart';
import 'package:projeto_pdm/model/Cobertura.dart';


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

    cadastroCobertura =
        db.collection("coberturas").snapshots().listen((snapshot) {
      final List<Cobertura> coberturas = snapshot.documents
          .map(
            (documentSnapshot) => Cobertura.fromMap(
                documentSnapshot.data, documentSnapshot.documentID),
          )
          .toList();

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
            stream: getListaCoberturas(),
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
                            child: ListTile(
                              title: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: (Text(coberturas[index].descricao)),
                                ),
                              ),
                              onTap: () =>
                                  _irParaCbertura(context, coberturas[index]),
                            ),
                            background: Container(
                              color: Colors.red.withOpacity(0.8),

                            ),
                            onDismissed: (direction) {
                              _excluirCobertura(
                                  context, documentos[index], index);
                            },
                          );
                        }),
                  );
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => _criarCobertura(context , Cobertura(null, "")),
      child: Icon(Icons.add),),
    );
  }

  Stream<QuerySnapshot> getListaCoberturas() {
    return Firestore.instance.collection("coberturas").snapshots();
  }

  void _excluirCobertura(
      BuildContext context, DocumentSnapshot doc, int position) async {
    db.collection("coberturas").document(doc.documentID).delete();

    setState(() {
      coberturas.removeAt(position);
    });
  }

  void _irParaCbertura(context, Cobertura cobertura) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => FormularioCobertura(cobertura)));
  }

  void _criarCobertura(BuildContext context, Cobertura cobertura)async {
    await Navigator.push(context, MaterialPageRoute(builder: 
    (context) => FormularioCobertura(Cobertura(null, ""))));
    //setState(() {});
  }
}


