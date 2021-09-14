import 'package:cloud_firestore/cloud_firestore.dart';

class Apiario {

  String keyApiario;
  String nome;
  String logradouro;
  String latitude;
  String longitude;
  Timestamp dataAtualizacao;
  String criadoPor;

  Apiario({
    required this.keyApiario,
    required this.nome,
    required this.logradouro,
    required this.latitude,
    required this.longitude,
    required this.dataAtualizacao,
    required this.criadoPor
  });

}