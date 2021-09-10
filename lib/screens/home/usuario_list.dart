import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsuarioList extends StatefulWidget {
  @override
  _UsuarioListState createState() => _UsuarioListState();
}

class _UsuarioListState extends State<UsuarioList> {
  @override
  Widget build(BuildContext context) {

    final usuarios = Provider.of<QuerySnapshot?>(context);
    print(usuarios!.docs);
    for (var doc in usuarios!.docs) {
      print(doc.data());
    }

    return Container();
  }
}
