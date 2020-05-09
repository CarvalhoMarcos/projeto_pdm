import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/model/Especialidade.dart';
import 'package:projeto_pdm/services/EspecialidadeService.dart';

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
            stream: EspecialidadeService().getListaEspecialidades(),
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
                                    EspecialidadeService().irParaEspecialidade(context, especialidades[index]),
                              ),
                            ),
                            background: Container(
                              color: Colors.red.withOpacity(0.8),

                            ),
                            onDismissed: (direction) {
                              EspecialidadeService().excluirEspecialidade(
                                  context, documentos[index], index, setState, especialidades);
                            },
                          );
                        }),
                  );
              }
            },
          )
        ]
      ),
            floatingActionButton: FloatingActionButton(onPressed: () => EspecialidadeService().criarEspecialidade(context , Especialidade(null, "")),
      child: Icon(Icons.add),),
    );
  }
}
