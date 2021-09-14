import 'package:cloud_firestore/cloud_firestore.dart';

class Apiario {

  String nome;
  String logradouro;
  String latitude;
  String longitude;
  Timestamp dataAtualizacao;

  Apiario({
    required this.nome,
    required this.logradouro,
    required this.latitude,
    required this.longitude,
    required this.dataAtualizacao
  });

}