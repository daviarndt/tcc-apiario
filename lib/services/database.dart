import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_apiario/models/apiario.dart';
import 'package:tcc_apiario/models/caixa.dart';
import 'package:tcc_apiario/models/manutencao.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({ this.uid });
  
  final CollectionReference usuarioCollection = FirebaseFirestore.instance.collection('usuario');
  final CollectionReference apiarioCollection = FirebaseFirestore.instance.collection('apiario');
  final CollectionReference caixaCollection = FirebaseFirestore.instance.collection('caixa');
  final CollectionReference manutencaoCollection = FirebaseFirestore.instance.collection('manutencao');

  Future createDatabaseForNewUser(String name, String email) async {
    return await usuarioCollection.doc(uid).set({
      'name': name,
      'email:': email
    });
  }

  Future addApiario(String nome, String logradouro, String latitude, String longitude, Timestamp dataAtualizacao, String criadoPor) async {
    return await apiarioCollection.add({
      'nome': nome,
      'logradouro': logradouro,
      'latitude': latitude,
      'longitude': longitude,
      'dataAtualizacao': dataAtualizacao,
      'criadoPor': criadoPor
    });
  }

  Future updateApiario(String doc, String nome, String logradouro, String latitude, String longitude, Timestamp dataAtualizacao, String criadoPor) async {
    return await apiarioCollection
        .doc(doc)
        .update({
      'nome': nome,
      'logradouro': logradouro,
      'latitude': latitude,
      'longitude': longitude,
      'dataAtualizacao': dataAtualizacao,
      'criadoPor': criadoPor
    });
  }

  Future removeApiario(String doc) async {
    return await apiarioCollection.doc(doc).delete();
  }

  Stream<List<Apiario>> get apiarios {
    return apiarioCollection
      .where('criadoPor', isEqualTo: uid)
      .snapshots()
      .map(_apiarioListFromSnapshot);
  }

  List<Apiario> _apiarioListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Apiario(
          keyApiario: doc.id,
          nome: doc.data()['nome'],
          logradouro: doc.data()['logradouro'],
          latitude: doc.data()['latitude'],
          longitude: doc.data()['longitude'],
          dataAtualizacao: doc.data()['dataAtualizacao'],
          criadoPor: doc.data()['criadoPor']
      );
    }).toList();
  }

  Future addCaixa(String numeroCaixa, String modelo, String tipoRainha, String grauSanguineo, Timestamp dataAtualizacao, String keyApiario, String nomeFornecedor, String emailFornecedor, String telefoneFornecedor) async {
    return await caixaCollection.add({
      'numeroCaixa': numeroCaixa,
      'modelo': modelo,
      'grauSanguineo': grauSanguineo,
      'tipoRainha': tipoRainha,
      'dataAtualizacao': dataAtualizacao,
      'keyApiario': keyApiario,
      'nomeFornecedor': nomeFornecedor,
      'emailFornecedor': emailFornecedor,
      'telefoneFornecedor': telefoneFornecedor
    });
  }

  Future updateCaixa(String doc, String numeroCaixa, String modelo, String tipoRainha, String grauSanguineo, Timestamp dataAtualizacao, String nomeFornecedor, String emailFornecedor, String telefoneFornecedor) async {
    return await caixaCollection
        .doc(doc)
        .update({
      'numeroCaixa': numeroCaixa,
      'modelo': modelo,
      'grauSanguineo': grauSanguineo,
      'tipoRainha': tipoRainha,
      'dataAtualizacao': dataAtualizacao,
      'nomeFornecedor': nomeFornecedor,
      'emailFornecedor': emailFornecedor,
      'telefoneFornecedor': telefoneFornecedor
    });
  }

  Future removeCaixa(String doc) async {
    return await caixaCollection.doc(doc).delete();
  }

  Stream<List<Caixa>> getCaixas(String keyApiario) {
    return caixaCollection
        .where('keyApiario', isEqualTo: keyApiario)
        .snapshots()
        .map(_caixaListFromSnapshot);
  }

  List<Caixa> _caixaListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Caixa(
        keyCaixa: doc.id,
        numeroCaixa: doc.data()['numeroCaixa'],
        modelo: doc.data()['modelo'], grauSanguineo: doc.data()['grauSanguineo'],
        tipoRainha: doc.data()['tipoRainha'],
        dataAtualizacao: doc.data()['dataAtualizacao'],
        apiarioKey: doc.data()['apiarioKey'],
        nomeFornecedor: doc.data()['nomeFornecedor'],
        emailFornecedor: doc.data()['emailFornecedor'],
        telefoneFornecedor: doc.data()['telefoneFornecedor']
      );
    }).toList();
  }

  Future addManutencao(String descricao, Timestamp dataManutencao, String keyCaixa) async {
    return await manutencaoCollection.add({
      'descricao': descricao,
      'dataManutencao': dataManutencao,
      'keyCaixa': keyCaixa,
    });
  }

  Future updateManutencao(String doc, String descricao, Timestamp dataManutencao) async {
    return await manutencaoCollection.doc(doc)
        .update({
      'descricao': descricao,
      'dataManutencao': dataManutencao,
    });
  }

  Future removeManutencao(String doc) async {
    return await manutencaoCollection.doc(doc).delete();
  }

  Stream<List<Manutencao>> getManutencoes(String keyCaixa) {
    return manutencaoCollection
        .where('keyCaixa', isEqualTo: keyCaixa)
        .orderBy('dataManutencao', descending: true)
        // .limit(10)
        .snapshots()
        .map(_manutencaoListFromSnapshot);
  }

  List<Manutencao> _manutencaoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Manutencao(
        keyManutencao: doc.id,
        descricao: doc.data()['descricao'],
        dataManutencao: doc.data()['dataManutencao'],
        caixaKey: doc.data()['caixaKey']
      );
    }).toList();
  }
}
