
import 'package:flutter/material.dart';
import 'login/login.view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Match Perfeito',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: LoginManagerScreen() //MyHomePage(title: 'Match Perfeito')
        );
    }
}

