import 'package:flutter/material.dart';
import 'package:project_ppkd/preferences/preferences_handler.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  // startSplashScreen() async {
  //   var duration = const Duration(seconds: 2);
  //   return Future.delayed(duration, () {
  //     Navigator.of(context).pushReplacementNamed('/login');
  //   });
  // }
  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  Future<void> _startSplashScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    bool? isLoggedIn = await PreferencesHandler.getLogin();
    if (isLoggedIn == true) {
      Navigator.of(context).pushReplacementNamed('/bottomnav');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.blueGrey,
  body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
        child: Image.asset(
          "assets/images/facebook.png",
          width: 200.0,
          height: 100.0,
          fit: BoxFit.contain,
        ),
      ),
      SizedBox(
        height: 24.0,
      ),
      Text(
        "MOVIE APPS",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
        ),
      ),
    ],
  ),
    );
  }
}