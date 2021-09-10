import 'package:flutter/material.dart';
import 'package:tcc_apiario/services/auth.dart';
import 'package:tcc_apiario/shared/constants.dart';
import 'package:tcc_apiario/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String name = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xFFEFC88B),
            appBar: AppBar(
              backgroundColor: Color(0xFFCF5C36),
              elevation: 0.0,
              title: Text('Registrar para Apiário'),
              actions: [
                TextButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Entrar'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
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
                        validator: (value) =>
                            value!.isEmpty ? 'Digite um nome' : null,
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Nome'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? 'Digite um email' : null,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (value) => value!.length < 6
                            ? 'Digite uma senha com 6+ caracteres'
                            : null,
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Senha'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFCF5C36)),
                        ),
                        child: Text(
                          'Registrar',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    name, email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Por favor entre com um email válido';
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                )),
          );
  }
}
