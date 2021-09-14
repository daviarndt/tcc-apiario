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

  Future createDatabaseForNewApiario(String nome, String logradouro, String latitude, String longitude, DateTime dataAtualizacao) async {
    return await apiarioCollection.doc(uid).set({
      'nome': nome,
      'logradouro': logradouro,
      'latitude': latitude,
      'longitude': longitude,
      'dataAtualizacao': dataAtualizacao
    });
  }

  List<Apiario> _apiarioListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Apiario(
        nome: doc.data()['nome'],
        logradouro: doc.data()['logradouro'],
        latitude: doc.data()['latitude'],
        longitude: doc.data()['longitude'],
          dataAtualizacao: doc.data()['dataAtualizacao'].toString()
      );
    }).toList();
  }

  Stream<List<Apiario>> get apiarios {
    return apiarioCollection.snapshots()
      .map(_apiarioListFromSnapshot);
  }

}
