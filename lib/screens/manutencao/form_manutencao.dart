import 'package:flutter/material.dart';
import 'package:tcc_apiario/models/manutencao.dart';

class FormManutencao extends StatefulWidget {
  final Manutencao? manutencao;
  final String? keyCaixa;
  FormManutencao({ this.manutencao, this.keyCaixa });

  @override
  _FormManutencaoState createState() => _FormManutencaoState();
}

class _FormManutencaoState extends State<FormManutencao> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
