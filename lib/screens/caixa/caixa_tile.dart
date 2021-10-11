import 'package:flutter/material.dart';
import 'package:tcc_apiario/models/caixa.dart';
import 'package:tcc_apiario/screens/caixa/form_caixa.dart';
import 'package:tcc_apiario/screens/manutencao/manutencao_home.dart';
import 'package:tcc_apiario/services/database.dart';

class CaixaTile extends StatelessWidget {
  final Caixa caixa;

  CaixaTile({ required this.caixa });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/icons/bee-box.png'))
            ),
          ),
          title: Text(caixa.numeroCaixa + ' - ' + caixa.modelo, style: TextStyle(fontSize: 24.0)),
          subtitle: Text('Abelha ' + caixa.tipoRainha + ' - ' + caixa.grauSanguineo,
              style: TextStyle(fontSize: 16.0)),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ManutencaoHome(keyCaixa: caixa.keyCaixa, caixaNumero: caixa.numeroCaixa)));
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
                                              DatabaseService()
                                                  .removeCaixa(caixa.keyCaixa);
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            })
                                      ],
                                    );
                                  });
                            }),
                        ElevatedButton(
                            child: Text('Editar Caixa'),
                            // TO DO
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      FormCaixa(caixa: caixa)));
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
