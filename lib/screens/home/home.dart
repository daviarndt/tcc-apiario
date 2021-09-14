import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_apiario/models/apiario.dart';
import 'package:tcc_apiario/screens/apiario/form_apiario.dart';
import 'package:tcc_apiario/services/auth.dart';
import 'package:tcc_apiario/services/database.dart';

import 'apiario_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamProvider<List<Apiario>?>.value(
        initialData: null,
        value: DatabaseService(uid: '').apiarios,
        child: Scaffold(
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
          body: ApiarioList(),
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
        ),
      ),
    );
  }
}
