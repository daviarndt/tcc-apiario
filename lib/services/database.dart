import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });
  
  final CollectionReference apiarioCollection = FirebaseFirestore .instance.collection('tcc-apiario');

  Future createDatabaseForNewUser(String name) async {
    return await apiarioCollection.doc(uid).set({
      'name': name
    });
  }
}
