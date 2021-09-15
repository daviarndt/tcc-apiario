import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_apiario/models/caixa.dart';
import 'package:tcc_apiario/models/user_custom.dart';
import 'package:tcc_apiario/screens/caixa/form_caixa.dart';
import 'package:tcc_apiario/services/database.dart';

class CaixaTile extends StatelessWidget {
  final Caixa caixa;

  CaixaTile({ required this.caixa });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserCustom>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.map),
          title: Text(caixa.numeroCaixa, style: TextStyle(fontSize: 24.0)),
          subtitle: Text(caixa.modelo, style: TextStyle(fontSize: 16.0)),
          onTap: () {
            // TO DO...
          },
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
                            child: Text('Remover Caixa'),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Remover Caixa?'),
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
                                              DatabaseService().removeCaixa(caixa.keyCaixa);
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            })
                                      ],
                                    );
                                  });
                            }),
                        ElevatedButton(
                            child: Text('Editar Apiário'),
                            // TO DO
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FormCaixa(
                                    caixa: caixa
                                  )));
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
