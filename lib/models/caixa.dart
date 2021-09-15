import 'package:cloud_firestore/cloud_firestore.dart';

class Caixa {

  String keyCaixa;
  String numeroCaixa;
  String modelo;
  Timestamp dataAtualizacao;
  String apiarioKey;

  Caixa({
    required this.keyCaixa,
    required this.numeroCaixa,
    required this.modelo,
    required this.dataAtualizacao,
    required this.apiarioKey
  });
}