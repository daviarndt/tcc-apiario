import 'package:flutter/material.dart';
import 'package:tcc_apiario/models/manutencao.dart';
import 'package:intl/intl.dart';

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
          title: Text(DateFormat('dd/MM/yyyy').format(manutencao.dataManutencao.toDate())),
          subtitle: Text(manutencao.descricao),
        ),
      ),
    );
  }
}
