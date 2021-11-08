import 'package:cloud_firestore/cloud_firestore.dart';

class Caixa {

  String keyCaixa;
  String numeroCaixa;
  String modelo;
  String tipoRainha;
  String grauSanguineo;
  Timestamp dataAtualizacao;
  String apiarioKey;
  String nomeFornecedor;
  String emailFornecedor;
  String telefoneFornecedor;

  Caixa({
    required this.keyCaixa,
    required this.numeroCaixa,
    required this.modelo,
    required this.grauSanguineo,
    required this.tipoRainha,
    required this.dataAtualizacao,
    required this.apiarioKey,
    required this.nomeFornecedor,
    required this.emailFornecedor,
    required this.telefoneFornecedor
  });
}