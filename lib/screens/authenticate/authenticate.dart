import 'package:flutter/material.dart';
import 'package:tcc_apiario/screens/authenticate/register.dart';
import 'package:tcc_apiario/screens/authenticate/sign_in.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }
}
