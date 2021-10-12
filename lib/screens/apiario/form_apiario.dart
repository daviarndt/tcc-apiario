import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc_apiario/models/apiario.dart';
import 'package:tcc_apiario/services/database.dart';
import 'package:tcc_apiario/shared/constants.dart';

class FormApiario extends StatefulWidget {
  final Apiario? apiario;
  final String userId;
  FormApiario({ this.apiario, required this.userId });

  @override
  _FormApiarioState createState() => _FormApiarioState();
}

class _FormApiarioState extends State<FormApiario> {
  String nome = '';
  String logradouro = '';
  String latitude = '';
  String longitude = '';

  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _logradouroController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  @override
  void initState() {
    if (widget.apiario != null) {
      _nomeController.text = widget.apiario!.nome;
      nome = widget.apiario!.nome;
      _logradouroController.text = widget.apiario!.logradouro;
      logradouro = widget.apiario!.logradouro;
      _latitudeController.text = widget.apiario!.latitude;
      latitude = widget.apiario!.latitude;
      _longitudeController.text = widget.apiario!.longitude;
      longitude = widget.apiario!.longitude;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.apiario != null ? 'Editar Apiário: ' + widget.apiario!.nome : 'Cadastrar Apiário'),
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
                  controller: _nomeController,
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
                  controller: _logradouroController,
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
                    keyboardType: TextInputType.number,
                  controller: _latitudeController,
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
                    keyboardType: TextInputType.number,
                  controller: _longitudeController,
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
                      if (widget.apiario == null){
                        await DatabaseService().addApiario(nome, logradouro, latitude, longitude, Timestamp.now(), widget.userId);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Apiário Cadastrado')
                            )
                        );
                      } else {
                        await DatabaseService().updateApiario(widget.apiario!.keyApiario, nome, logradouro, latitude, longitude, Timestamp.now(), widget.userId);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Apiário Editado')
                            )
                        );
                      }
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
