import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_pdm/model/RequisicaoExame.dart';

class RequisicaoService{
 static final RequisicaoService _requisicaoService =
      RequisicaoService._internal();

  factory RequisicaoService() {
    return _requisicaoService;
  }
  RequisicaoService._internal();

  final db = Firestore.instance;

     Stream<QuerySnapshot> getListaRquisicao() {
    return Firestore.instance.collection("requisicaoExames").snapshots();
  }

  Future<String> criarRquisicao(RequisicaoExame requisicao) async {
    DocumentReference doc = await db.collection("requisicaoExames").add(requisicao.toMap());
    return doc.documentID;
  }
  
  void setData(Map<String, dynamic> map, RequisicaoExame requisicao){
    db.collection("requisicaoExames").document(requisicao.id).setData(map);
  }

  Future<RequisicaoExame> getRquisicaoPorId(String requisicaoId) async {
    var documento = await db.collection("requisicaoExames").document(requisicaoId).get();
    return RequisicaoExame.fromMap(documento.data, documento.documentID);
  }
}