import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/formularios/FormEspecialidade.dart';
import 'package:projeto_pdm/model/Especialidade.dart';

class EspecialidadeService {
  static final EspecialidadeService _especialidadeService =
      EspecialidadeService._internal();

  factory EspecialidadeService() {
    return _especialidadeService;
  }
  EspecialidadeService._internal();

  final db = Firestore.instance;

      Stream<QuerySnapshot> getListaEspecialidades() {
    return Firestore.instance.collection("especialidades").snapshots();
  }

  void excluirEspecialidade(BuildContext context, DocumentSnapshot doc, int position, Function setState, List lista) async {
    db.collection("especialidades").document(doc.documentID).delete();

    setState(() {
      lista.removeAt(position);
    });
  }

  void irParaEspecialidade(context, Especialidade especialidade) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => FormularioEspecialidade(especialidade)));
  }

  void criarEspecialidade(BuildContext context, Especialidade cobertura)async {
    await Navigator.push(context, MaterialPageRoute(builder: 
    (context) => FormularioEspecialidade(Especialidade(null, ""))));
    //setState(() {});
  }
   void setData(Map<String, dynamic> map, Especialidade especialidade){
    db.collection("especialidades").document(especialidade.id).setData(map);
  }

    List<Especialidade> listarEspecialidades(){
    List<Especialidade> especialidade;
    db.collection("especialidades").snapshots().listen((snapshot) {
      especialidade = snapshot.documents.map((documentSnapshot) => Especialidade.fromMap(
        documentSnapshot.data, documentSnapshot.documentID),
      ).toList();
     });
      return especialidade;  
  }

  // Future<Especialidade> getEspecialidadePorId(String especialidadeId) async {
  //   Especialidade especialidade;
  //   var docSnap = await db.collection("especialidades").document(especialidadeId).get();
  //   especialidade = Especialidade.fromMap(docSnap.data, docSnap.documentID);
  //   return especialidade;
  // }

  Stream<DocumentSnapshot> getEspecialidadePorId(String especialidadeId){
    return db.collection("especialidades").document(especialidadeId).snapshots();
  }

}
