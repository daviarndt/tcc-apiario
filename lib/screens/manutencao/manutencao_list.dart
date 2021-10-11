import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcc_apiario/models/manutencao.dart';
import 'package:tcc_apiario/screens/manutencao/manutencao_tile.dart';

class ManutencaoList extends StatefulWidget {
  @override
  _ManutencaoListState createState() => _ManutencaoListState();
}

class _ManutencaoListState extends State<ManutencaoList> {
  @override
  Widget build(BuildContext context) {

    final manutencoes = Provider.of<List<Manutencao>?>(context) ?? [];

    return ListView.builder(
        itemCount: manutencoes.length,
        itemBuilder: (context, index) {
          return ManutencaoTile(manutencao: manutencoes[index]);
        }
    );
  }
}
