import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_apiario/models/apiario.dart';

class ApiarioList extends StatefulWidget {
  @override
  _ApiarioListState createState() => _ApiarioListState();
}

class _ApiarioListState extends State<ApiarioList> {
  @override
  Widget build(BuildContext context) {

    final apiarios = Provider.of<List<Apiario>?>(context) ?? [];

    apiarios.forEach((apiario) {
      print(apiario.nome);
      print(apiario.logradouro);
      print(apiario.latitude);
      print(apiario.longitude);
      print(apiario.dataAtualizacao);
    });

    return Container();
  }
}
