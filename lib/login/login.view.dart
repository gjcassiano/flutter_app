import 'package:flutter/material.dart';
import 'package:m_perfeito/login/login.controller.dart';

class LoginManagerScreen extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _LoginManagerScreenState();
}

class _LoginManagerScreenState extends State<LoginManagerScreen> {
    
    @override
    void initState() {
        super.initState();
        new LoginController().checkLoginAndDoAction(context);
    }
    
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
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

