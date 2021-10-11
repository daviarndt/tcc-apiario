import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_apiario/models/caixa.dart';
import 'caixa_tile.dart';

class CaixaList extends StatefulWidget {
  @override
  _CaixaListState createState() => _CaixaListState();
}

class _CaixaListState extends State<CaixaList> {
  @override
  Widget build(BuildContext context) {

    final caixas = Provider.of<List<Caixa>?>(context) ?? [];

    return ListView.builder(
      itemCount: caixas.length,
      itemBuilder: (context, index) {
        return CaixaTile(caixa: caixas[index]);
      },
    );
  }
}
