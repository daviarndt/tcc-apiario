import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_apiario/models/apiario.dart';
import 'package:tcc_apiario/models/user_custom.dart';
import 'package:tcc_apiario/screens/caixa/caixa_home.dart';
import 'package:tcc_apiario/services/database.dart';
import 'form_apiario.dart';

class ApiarioTile extends StatelessWidget {
  final Apiario apiario;

  ApiarioTile({required this.apiario});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserCustom>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/icons/bee-hive.png'))
            ),
          ),
          title: Text(apiario.nome, style: TextStyle(fontSize: 24.0)),
          subtitle: Text(apiario.logradouro, style: TextStyle(fontSize: 16.0)),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    CaixaHome(keyApiario: apiario.keyApiario,)));
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
                            child: Text('Remover Apiário'),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Remover Apiário?'),
                                      content: Text(
                                          'Esta ação é irreversível. Remover o apiário também removerá todas as caixas dentro dele.'),
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
                                              DatabaseService(uid: user.uid)
                                                  .removeApiario(
                                                      apiario.keyApiario);
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
                                  builder: (context) => FormApiario(
                                        apiario: apiario,
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
