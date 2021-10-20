import 'package:flutter/material.dart';
import 'package:tcc_apiario/models/manutencao.dart';
import 'package:intl/intl.dart';
import 'package:tcc_apiario/services/database.dart';

import 'form_manutencao.dart';

class ManutencaoTile extends StatelessWidget {
  final Manutencao manutencao;

  ManutencaoTile({ required this.manutencao });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.assignment_outlined, size: 40.0,),
          title: Text(DateFormat('dd/MM/yyyy').format(manutencao.dataManutencao.toDate())),
          subtitle: Text(manutencao.descricao, maxLines: 1, overflow: TextOverflow.ellipsis,),
          trailing: GestureDetector(
            child: Icon(Icons.more_vert),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Opções'),
                      actions: [
                        ElevatedButton(
                            child: Text('Remover Manutenção'),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Remover Manutenção?'),
                                      content: Text(
                                          'Esta ação é irreversível. Tem certeza?'),
                                      actions: [
                                        TextButton(
                                            child: Text('Não'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            }),
                                        TextButton(
                                            child: Text('Sim'),
                                            onPressed: () {
                                              DatabaseService()
                                                  .removeManutencao(manutencao.keyManutencao);
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            })
                                      ],
                                    );
                                  });
                            }),
                        ElevatedButton(
                            child: Text('Editar Manutenção'),
                            // TO DO
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      FormManutencao(manutencao: manutencao)));
                            })
                      ],
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
