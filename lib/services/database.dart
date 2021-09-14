import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_apiario/models/apiario.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });
  
  final CollectionReference usuarioCollection = FirebaseFirestore.instance.collection('usuario');
  final CollectionReference apiarioCollection = FirebaseFirestore.instance.collection('apiario');

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

  Future removeApiario(String doc) async {
    return await apiarioCollection.doc(doc).delete();
  }

  Stream<List<Apiario>> get apiarios {
    return apiarioCollection.snapshots()
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

}
