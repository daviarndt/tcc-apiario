// @dart = 2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_apiario/models/user_custom.dart';
import 'package:tcc_apiario/screens/wrapper.dart';
import 'package:tcc_apiario/services/auth.dart';
import 'package:splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProjetoApiario());
}

class ProjetoApiario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen',
      home: HomePage(title: 'Splash Screen'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 3,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFFFFFF),
            Color(0xCFCFCF)
          ],
        ),
        navigateAfterSeconds: StreamProvider<UserCustom>.value(
          initialData: null,
          value: AuthService().user,
          child: MaterialApp(
            home: Wrapper(),
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
          ),
        ),
        loaderColor: Colors.transparent,
      ),
      Center(
        child: Container(
          height: 128,
          width: 128,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icons/honeycombs.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ],
  );
}
