import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_pdm/model/Endereco.dart';

class EnderecoService{
 static final EnderecoService _enderecoService =
      EnderecoService._internal();

  factory EnderecoService() {
    return _enderecoService;
  }
  EnderecoService._internal();

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
    Stream<QuerySnapshot> getListaEnderecos() {
    return Firestore.instance.collection("enderecos").snapshots();
  }

  Future<String> criarEndereco(Endereco endereco) async {
    DocumentReference doc = await db.collection("enderecos").add(endereco.toMap());
    return doc.documentID;
  }
  
  void setData(Map<String, dynamic> map, Endereco endereco){
    db.collection("enderecos").document(endereco.id).setData(map);
  }

  Future<Endereco> getEnderecoPorId(String enderecoId) async {
    var documento = await db.collection("enderecos").document(enderecoId).get();
    return Endereco.fromMap(documento.data, documento.documentID);
  }

}