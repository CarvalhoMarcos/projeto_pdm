import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_pdm/model/Endereco.dart';
import 'package:projeto_pdm/model/Prescicao.dart';


class ReceitaService{
 static final ReceitaService _receitaService =
      ReceitaService._internal();

  factory ReceitaService() {
    return _receitaService;
  }
  ReceitaService._internal();

  final db = Firestore.instance;

  //   void irParaEndereco(context, Endereco cobertura) async {
  //   await Navigator.push(context,MaterialPageRoute(
  //           builder: (context) => Formulario(cobertura)));
  // }

  //   void excluirCobertura(BuildContext context, DocumentSnapshot doc, int position, Function setState, List coberturas) async {
  //     db.collection("enderecos").document(doc.documentID).delete();

  //     setState(() {
  //       coberturas.removeAt(position);
  //     });
  // }
    Stream<QuerySnapshot> getListaReceitas() {
    return Firestore.instance.collection("receitas").snapshots();
  }

  Future<String> criarReceita(PrescricaoMedicamento receita) async {
    DocumentReference doc = await db.collection("receitas").add(receita.toMap());
    return doc.documentID;
  }
  
  void setData(Map<String, dynamic> map, PrescricaoMedicamento receita){
    db.collection("receitas").document(receita.id).setData(map);
  }

  Future<PrescricaoMedicamento> getReceitaPorId(String receitaId) async {
    var documento = await db.collection("receitas").document(receitaId).get();
    return PrescricaoMedicamento.fromMap(documento.data, documento.documentID);
  }

}