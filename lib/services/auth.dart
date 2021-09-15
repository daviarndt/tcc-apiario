import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_apiario/models/user_custom.dart';
import 'package:tcc_apiario/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user obj based on User
  UserCustom? _userFromFirebaseUser(User user) {
    return user != null ? UserCustom(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<UserCustom?> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email and password
  Future registerWithEmailAndPassword(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // Create document for new user
      await DatabaseService(uid: user.uid).createDatabaseForNewUser(name, email);

      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}
