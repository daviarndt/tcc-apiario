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
  String numeroCaixa = '';
  String? modelo = 'Langstroth';
  String? tipoRainha = 'Africana';
  String? grauSanguineo = 'F1';

  final _formKey = GlobalKey<FormState>();

  final _numeroCaixaController = TextEditingController();

  @override
  void initState() {
    if (widget.caixa != null) {
      _numeroCaixaController.text = widget.caixa!.numeroCaixa;
      numeroCaixa = widget.caixa!.numeroCaixa;
      modelo = widget.caixa!.modelo;
      tipoRainha = widget.caixa!.tipoRainha;
      grauSanguineo = widget.caixa!.grauSanguineo;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.caixa != null ? 'Editar Caixa: ' + widget.caixa!.numeroCaixa : 'Cadastrar Caixa'),
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
                  controller: _numeroCaixaController,
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Digite o número de registro da caixa' : null,
                  onChanged: (value) {
                    setState(() {
                      numeroCaixa = value;
                    });
                  },
                  decoration: textInputDecoration.copyWith(hintText: 'Número'),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                      child: Text('Modelo: ', style: TextStyle(fontSize: 16.0),),
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
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                      child: Text('Tipo da Rainha: ', style: TextStyle(fontSize: 16.0),),
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
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                      child: Text('Grau Sanguíneo: ', style: TextStyle(fontSize: 16.0),),
                    ),
                    DropdownButton<String>(
                        value: grauSanguineo,
                        onChanged: (String? newValue) {
                          setState(() {
                            grauSanguineo = newValue!;
                          });
                        },
                        items: <String>['F1', 'F2', 'Puro']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  ],
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
                      if (widget.caixa == null){
                        await DatabaseService().addCaixa(numeroCaixa, modelo!, tipoRainha!, grauSanguineo!, Timestamp.now(), widget.keyApiario!);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Caixa Cadastrada')
                            )
                        );
                      } else {
                        await DatabaseService().updateCaixa(widget.caixa!.keyCaixa, numeroCaixa, modelo!, tipoRainha!, grauSanguineo!, Timestamp.now());
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Caixa Editada')
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
