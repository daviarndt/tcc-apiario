import 'package:flutter/material.dart';
import 'package:tcc_apiario/models/manutencao.dart';

class ManutencaoTile extends StatelessWidget {
  final Manutencao manutencao;

  ManutencaoTile({ required this.manutencao });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.assignment_outlined),
          title: Text(manutencao.dataManutencao.toString()),
          subtitle: Text(manutencao.descricao),
        ),
      ),
    );
  }
}
