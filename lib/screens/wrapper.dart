import 'package:flutter/material.dart';
import 'package:tcc_apiario/screens/authenticate/authenticate.dart';
import 'package:tcc_apiario/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Return Home or Authenticate
    return Authenticatee();
  }
}
