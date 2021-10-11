import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_apiario/models/manutencao.dart';
import 'package:tcc_apiario/screens/manutencao/form_manutencao.dart';
import 'package:tcc_apiario/services/database.dart';
import 'package:tcc_apiario/shared/loading.dart';

import 'manutencao_list.dart';

class ManutencaoHome extends StatelessWidget {
  final String keyCaixa;
  final String caixaNumero;

  ManutencaoHome({ required this.keyCaixa, required this.caixaNumero });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Manutenções da caixa: ' + caixaNumero),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      body: StreamProvider<List<Manutencao>?>.value(
        initialData: null,
        value: DatabaseService().getManutencoes(keyCaixa),
        child: StreamBuilder<List<Manutencao>?>(
          stream: DatabaseService().getManutencoes(keyCaixa),
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
                  child: Text('Ainda não existem manutenções cadastradas para esta caixa...'),
                );
              }

              return ManutencaoList();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FormManutencao(keyCaixa: keyCaixa),
            ),
          );
        },
      ),
    );
  }
}
