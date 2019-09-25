import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login.dart';

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ConfigurationPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _name;
  int _age;

  _submit() {
    if (_formKey.currentState.validate()) {
      // No any error in validation
      _formKey.currentState.save();
    }
  }

  final LoginManager _loginManager = new LoginManager();

  _logout() {
    _loginManager.logout();
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  String numberValidator(String value) {
    if (value == null) {
      return null;
    }
    final n = num.tryParse(value);
    if (n == null || n as int <= 18) {
      return 'Deve ser maior que 18';
    }
    return null;
  }


  
  @override
  Widget build(BuildContext context) {
      int _radioValue = 1;
      void handleRadioValueChanged(int value) {
        
          _radioValue = value;
      }
      
    return Container(
        child: new Form(
            key: _formKey,
            child: new ListView(children: <Widget>[
              SizedBox(
                child: new PageView(
                  children: <Widget>[
                    Container(
                      color: Colors.blue,
                    ),
                    Container(
                      color: Colors.redAccent,
                    )
                  ],
                ),
                height: 250,
              ),
              new Container(
                  padding: EdgeInsets.all(20),
                  child: new Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      TextFormField(
                          onSaved: (name) {
                            _name = name;
                          },
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType
                              .text, // Use email input type for emails.
                          decoration: new InputDecoration(
                              alignLabelWithHint: true,
                              labelText: 'Seu apelido')),
                      TextFormField(
                          onSaved: (String age) {
                            _age = int.tryParse(age);
                          },
                          style: TextStyle(fontSize: 20),
                          validator: numberValidator,
                          keyboardType: TextInputType
                              .number, // Use email input type for em
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ], // ails.
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: 'Sua idade')),
                      new Text(
                        'Lion is :',
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      
                      new Container(
                          padding: EdgeInsets.all(20),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                                Radio(
                                    value: 0,
                                    groupValue: _radioValue,
                                    onChanged: null,
                                ),
                                Radio(
                                    value: 1,
                                    groupValue: _radioValue,
                                    onChanged: handleRadioValueChanged,
                                ),
                                Radio(
                                    value: 2,
                                    groupValue: _radioValue,
                                    onChanged: handleRadioValueChanged,
                                ),
                            ],
                          )),
                      new Container(
                          padding: const EdgeInsets.all(20.0),
                          child: new Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Divider(),
                              SizedBox(
                                width: double.infinity,
                                child: FlatButton(
                                    child: Text("Salvar"),
                                    onPressed: () {
                                      _submit();
                                    }),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: FlatButton(
                                    child: Text("Sair"),
                                    onPressed: () {
                                      _logout();
                                    }),
                              )
                            ],
                          ))
                    ],
                  )),
            ])));
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 1;
  Page1 page1;
  ConfigurationPage configurationPage;
  Widget currentPage;

  List<Widget> pages;

  @override
  void initState() {
    page1 = Page1();
    configurationPage = ConfigurationPage();
    pages = [page1, configurationPage];
    currentPage = page1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentPage,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPageIndex,
          fixedColor: Colors.black38,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.all_inclusive, color: Colors.blueAccent),
                title: new Text('Principal')),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu, color: Colors.blueAccent),
                title: new Text('Configuração'))
          ],
          onTap: (int index) {
            setState(() {
              currentPageIndex = index;
              currentPage = pages[index];
            });
          },
        ));
  }
}
