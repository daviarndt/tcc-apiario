import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });
  
  final CollectionReference usuarioCollection = FirebaseFirestore .instance.collection('usuario');

  Future createDatabaseForNewUser(String name) async {
    return await usuarioCollection.doc(uid).set({
      'name': name
    });
  }

  Stream<QuerySnapshot> get usuarios {
    return usuarioCollection.snapshots();
  }

}
