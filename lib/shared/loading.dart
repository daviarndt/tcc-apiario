import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEFC88B),
      child: Center(
        child: SpinKitChasingDots(
          color: Color(0xFFCF5C36),
          size: 50.0,
        ),
      ),
    );
  }
}
