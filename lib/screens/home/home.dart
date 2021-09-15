import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_apiario/models/apiario.dart';
import 'package:tcc_apiario/models/user_custom.dart';
import 'package:tcc_apiario/screens/apiario/form_apiario.dart';
import 'package:tcc_apiario/services/auth.dart';
import 'package:tcc_apiario/services/database.dart';
import 'package:tcc_apiario/shared/loading.dart';

import 'apiario_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserCustom>(context);

    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Apiários'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: StreamProvider<List<Apiario>?>.value(
        initialData: null,
        value: DatabaseService(uid: user.uid).apiarios,
        child: StreamBuilder<List<Apiario>?>(
            stream: DatabaseService(uid: user.uid).apiarios,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading();
              }

              if (snapshot.data!.length == 0) {
                return Center(
                  child: Text('Ainda não existem apiários cadastrados...'),
                );
              }

              return ApiarioList();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FormApiario(),
            ),
          );
        },
      ),
    );
  }
}
