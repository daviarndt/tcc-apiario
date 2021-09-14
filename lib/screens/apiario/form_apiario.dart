import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_apiario/models/apiario.dart';
import 'package:tcc_apiario/models/user_custom.dart';
import 'package:tcc_apiario/services/database.dart';
import 'package:tcc_apiario/shared/constants.dart';

class FormApiario extends StatefulWidget {
  final Apiario? apiario;
  FormApiario({ this.apiario });

  @override
  _FormApiarioState createState() => _FormApiarioState();
}

class _FormApiarioState extends State<FormApiario> {
  final _formKey = GlobalKey<FormState>();

  String nome = '';
  String logradouro = '';
  String latitude = '';
  String longitude = '';
  DateTime dataAtualizacao = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserCustom>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Apiário'),
        backgroundColor: Color(0xFFCF5C36),
        elevation: 0.0,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) => value!.isEmpty ? 'Digite o nome' : null,
                  onChanged: (value) {
                    setState(() {
                      nome = value;
                    });
                  },
                  decoration: textInputDecoration.copyWith(hintText: 'Nome'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) =>
                  value!.isEmpty ? 'Digite o logradouro' : null,
                  onChanged: (value) {
                    setState(() {
                      logradouro = value;
                    });
                  },
                  decoration: textInputDecoration.copyWith(hintText: 'Logradouro'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) =>
                  value!.isEmpty ? 'Digite a latitude' : null,
                  onChanged: (value) {
                    setState(() {
                      latitude = value;
                    });
                  },
                  decoration: textInputDecoration.copyWith(hintText: 'Latitude'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) =>
                  value!.isEmpty ? 'Digite a longitude' : null,
                  onChanged: (value) {
                    setState(() {
                      longitude = value;
                    });
                  },
                  decoration: textInputDecoration.copyWith(hintText: 'Longitude'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFCF5C36)),
                  ),
                  child: Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid).createDatabaseForNewApiario(nome, logradouro, latitude, longitude, DateTime.now());
                      Navigator.pop(context);
                    }
                  },
                ),
                SizedBox(height: 12.0),
              ],
            ),
          )),
    );
  }
}
