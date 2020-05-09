import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/formularios/FormEspecialidade.dart';
import 'package:projeto_pdm/model/Especialidade.dart';

class ListaEspecialidades extends StatefulWidget {
  @override
  _ListaEspecialidadesState createState() => _ListaEspecialidadesState();
}

class _ListaEspecialidadesState extends State<ListaEspecialidades> {
  var db = Firestore.instance;
  List<Especialidade> especialidades;

  StreamSubscription<QuerySnapshot> cadastroEspecialidade;

  @override
  void initState() {
    super.initState();

    especialidades = List();
    cadastroEspecialidade?.cancel();

    cadastroEspecialidade =
        db.collection("especialidades").snapshots().listen((snapshot) {
      final List<Especialidade> especialidades = snapshot.documents
          .map((documentSnapshot) => Especialidade.fromMap(
              documentSnapshot.data, documentSnapshot.documentID))
          .toList();

      setState(() {
        this.especialidades = especialidades;
      });
    });
  }

  @override
  void dispose(){
    cadastroEspecialidade?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Especialidades"),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: getListaEspecialidades(),
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
                            key: Key(especialidades[index].descricao),
                            child: Card(
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: (Text(especialidades[index].descricao)),
                                ),
                                onTap: () =>
                                    _irParaEspecialidade(context, especialidades[index]),
                              ),
                            ),
                            background: Container(
                              color: Colors.red.withOpacity(0.8),

                            ),
                            onDismissed: (direction) {
                              _excluirEspecialidade(
                                  context, documentos[index], index);
                            },
                          );
                        }),
                  );
              }
            },
          )
        ]
      ),
            floatingActionButton: FloatingActionButton(onPressed: () => _criarEspecialidade(context , Especialidade(null, "")),
      child: Icon(Icons.add),),
    );
  }
    Stream<QuerySnapshot> getListaEspecialidades() {
    return Firestore.instance.collection("especialidades").snapshots();
  }

  void _excluirEspecialidade(
      BuildContext context, DocumentSnapshot doc, int position) async {
    db.collection("especialidades").document(doc.documentID).delete();

    setState(() {
      especialidades.removeAt(position);
    });
  }

  void _irParaEspecialidade(context, Especialidade especialidade) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => FormularioEspecialidade(especialidade)));
  }

  void _criarEspecialidade(BuildContext context, Especialidade cobertura)async {
    await Navigator.push(context, MaterialPageRoute(builder: 
    (context) => FormularioEspecialidade(Especialidade(null, ""))));
    //setState(() {});
  }
}
