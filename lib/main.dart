// @dart = 2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_apiario/models/user_custom.dart';
import 'package:tcc_apiario/screens/wrapper.dart';
import 'package:tcc_apiario/services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProjetoApiario());
}

class ProjetoApiario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserCustom>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}