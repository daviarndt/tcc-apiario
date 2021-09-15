import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_apiario/models/apiario.dart';
import 'package:tcc_apiario/models/caixa.dart';
import 'package:tcc_apiario/models/user_custom.dart';
import 'package:tcc_apiario/screens/caixa/caixa_list.dart';
import 'package:tcc_apiario/screens/caixa/form_caixa.dart';
import 'package:tcc_apiario/services/auth.dart';
import 'package:tcc_apiario/services/database.dart';
import 'package:tcc_apiario/shared/loading.dart';

class CaixaHome extends StatelessWidget {
  final AuthService _auth = AuthService();

  final String? keyApiario;
  CaixaHome({ this.keyApiario });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserCustom>(context);

    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Caixas'),
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
      body: StreamProvider<List<Caixa>?>.value(
        initialData: null,
        value: DatabaseService().getCaixas(keyApiario!),
        child: StreamBuilder<List<Caixa>?>(
            stream: DatabaseService().getCaixas(keyApiario!),
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
                  child: Text('Ainda não existem caixas criadas...'),
                );
              }

              return CaixaList();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FormCaixa(keyApiario: keyApiario),
            ),
          );
        },
      ),
    );
  }
}
