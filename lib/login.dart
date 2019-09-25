
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:m_perfeito/main.dart';

class LoginManager {
  GoogleSignIn _googleSignIn;
  GoogleSignInAccount _currentUser;

  LoginManager() {
    _googleSignIn = GoogleSignIn( scopes: <String>['email']);
  }

  Future<bool> isLogged() async {
    return _googleSignIn.isSignedIn();
  }
  goToHome(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(title: 'Match Perfeito')),
    );
  }

  login(context) {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
        _currentUser = account;
        _googleSignIn.signInSilently();
        goToHome(context);
    });

    _googleSignIn.signIn();
  }
  logout() {
    _googleSignIn.disconnect();
  }
}

class LoginManagerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginManagerScreenState();
}

class _LoginManagerScreenState extends State<LoginManagerScreen> {

  @override
  void initState() {
    super.initState();

    LoginManager loginManager = new LoginManager();

    loginManager.isLogged().then((logged)=> {
      if (!logged) {
        loginManager.login(context)
      } else {
        loginManager.goToHome(context)
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Container(
                  child: CircularProgressIndicator(
                  strokeWidth: 5.0,
                  valueColor : AlwaysStoppedAnimation(Colors.blueAccent),
              )))

        ));
  }

}

