import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc_apiario/models/caixa.dart';
import 'package:tcc_apiario/services/database.dart';
import 'package:tcc_apiario/shared/constants.dart';

class FormCaixa extends StatefulWidget {
  final Caixa? caixa;
  final String? keyApiario;
  FormCaixa({ this.caixa, this.keyApiario });

  @override
  _FormCaixaState createState() => _FormCaixaState();
}

class _FormCaixaState extends State<FormCaixa> {
  final _formKey = GlobalKey<FormState>();

  String numeroCaixa = '';
  String? modelo = 'Langstroth';
  String? tipoRainha = 'Africana';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Caixa'),
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
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Digite o número de registro da caixa' : null,
                  onChanged: (value) {
                    setState(() {
                      numeroCaixa = value;
                    });
                  },
                  decoration: textInputDecoration.copyWith(hintText: 'Número'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButton<String>(
                    value: modelo,
                    onChanged: (String? newValue) {
                      setState(() {
                        modelo = newValue!;
                      });
                    },
                    items: <String>['Langstroth', 'Cortinaz', 'Schenk']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButton<String>(
                    value: tipoRainha,
                    onChanged: (String? newValue) {
                      setState(() {
                        tipoRainha = newValue!;
                      });
                    },
                    items: <String>['Africana', 'Europeia']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
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
                      await DatabaseService().addCaixa(numeroCaixa, modelo!, tipoRainha!, Timestamp.now(), widget.keyApiario!);
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
