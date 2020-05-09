import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/formularios/FormFormaPagamento.dart';
import 'package:projeto_pdm/model/FormaPagamento.dart';

class FormasPagamento extends StatefulWidget {
  @override
  _FormasPagamentoState createState() => _FormasPagamentoState();
}

class _FormasPagamentoState extends State<FormasPagamento> {
  var db = Firestore.instance;
  List<FormaPagamento> formasPagamento;

  StreamSubscription<QuerySnapshot> cadastroFormasPagamento;

  @override
  void initState() {
    super.initState();

    formasPagamento = List();
    cadastroFormasPagamento?.cancel();

    cadastroFormasPagamento =
        db.collection("formasPagamento").snapshots().listen((snapshot) {
      final List<FormaPagamento> tiposPagamento = snapshot.documents
          .map(
            (documentSnapshot) => FormaPagamento.fromMap(
                documentSnapshot.data, documentSnapshot.documentID),
          )
          .toList();

      setState(() {
        this.formasPagamento = tiposPagamento;
      });
    });
  }

  @override
  void dispose() {
    cadastroFormasPagamento?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formas de Pagamento"),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: getListaFormasPagamento(),
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
                            key: Key(formasPagamento[index].descricao),
                            child: Card(
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: (Text(formasPagamento[index].descricao)),
                                ),
                                onTap: () =>
                                    _irParaFormaPagamento(context, formasPagamento[index]),
                              ),
                            ),
                            background: Container(
                              color: Colors.red.withOpacity(0.8),
                            ),
                            onDismissed: (direction) {
                              _excluirFormaPagamento(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _criarFormaPagamento(context, FormaPagamento(null, "")),
        child: Icon(Icons.add),
      ),
    );
  }

  Stream<QuerySnapshot> getListaFormasPagamento() {
    return Firestore.instance.collection("formasPagamento").snapshots();
  }

  void _excluirFormaPagamento(
      BuildContext context, DocumentSnapshot doc, int position) async {
    db.collection("formasPagamento").document(doc.documentID).delete();

    setState(() {
      formasPagamento.removeAt(position);
    });
  }

  void _irParaFormaPagamento(context, FormaPagamento formaPagamento) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormularioFormaPagamento(formaPagamento)));
  }

  void _criarFormaPagamento(BuildContext context, FormaPagamento formaPagamento) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormularioFormaPagamento(FormaPagamento(null, ""))));
    //setState(() {});
  }
}
