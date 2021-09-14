import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_apiario/models/apiario.dart';
import 'package:tcc_apiario/screens/apiario/apiario_tile.dart';

class ApiarioList extends StatefulWidget {
  @override
  _ApiarioListState createState() => _ApiarioListState();
}

class _ApiarioListState extends State<ApiarioList> {
  @override
  Widget build(BuildContext context) {

    final apiarios = Provider.of<List<Apiario>?>(context) ?? [];

    return ListView.builder(
      itemCount: apiarios.length,
      itemBuilder: (context, index) {
        return ApiarioTile(apiario: apiarios[index]);
      },
    );
  }
}
