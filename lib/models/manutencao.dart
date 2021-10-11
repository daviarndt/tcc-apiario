import 'package:cloud_firestore/cloud_firestore.dart';

class Manutencao {

  String keyManutencao;
  String descricao;
  Timestamp dataManutencao;
  String caixaKey;

  Manutencao({
    required this.keyManutencao,
    required this.descricao,
    required this.dataManutencao,
    required this.caixaKey
  });
}