import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

class Configuration extends StatefulWidget {
    @override
    ConfigurationPage createState() => ConfigurationPage();
}

class ConfigurationPage extends State<Configuration>  {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  //Position userLocation;
  
  String _name;
  int _age;
  String _findPreference;
  
  _updateLocation() async {
      
      //Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
         // print(position);
      });
  }
  
  @override
  void initState() {
      super.initState();
      _read();
  }

  _read() async {
      final sharedPreferences = await SharedPreferences.getInstance();
     
      setState(() {
          _name = sharedPreferences.getString('_name') ?? '';
          _findPreference = sharedPreferences.getString('_findPreference') ?? 'Qualquer';
          _age = sharedPreferences.getInt('_age') ?? 0;
          print('Loaded configuration!');
      });
  }

  _save() async {
      final sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('_name', _name);
      sharedPreferences.setString('_findPreference', _findPreference);
      sharedPreferences.setInt('_age', _age);
  }
  
  _submit() {
      setState(() {
          if (_formKey.currentState.validate()) {
              // No any error in validation
              _formKey.currentState.save();
              _save();
          }
      });
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
    if (n == null || n as int < 18) {
      return 'Você tem que ser maior de idade';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Form(
            key: _formKey,
            child: new ListView(children: <Widget>[
              SizedBox(
                child: new PageView(
                  children: <Widget>[
                    Container(
                      child: FadeInImage.assetNetwork(
                          placeholder: 'assets/loading.gif',
                          image: 'https://scontent.fmao1-1.fna.fbcdn.net/v/t1.0-9/26239323_1566824216758972_4068455993475501954_n.jpg?_nc_cat=111&_nc_oc=AQmE_ME2QWagCQv7cc9IYl753KE0GpIbaph6ofAywnkJdaoPvjhAdpfUc4SNJt47A1S5UchQM0zfu-2GGNJFdTb9&_nc_ht=scontent.fmao1-1.fna&oh=4def1be2ef8ca2f64dcb44588d4af784&oe=5E3A8701',
                      ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      TextFormField(
                          controller: TextEditingController(text: _name),
                          onSaved: (name) {
                              setState(() => _name = name);
                          },
                          style: TextStyle(),
                          keyboardType: TextInputType
                              .text, // Use email input type for emails.
                          decoration: new InputDecoration(
                              alignLabelWithHint: true,
                              labelText: 'Seu apelido')),
                      TextFormField(
                          controller: TextEditingController(text: _age.toString()),
                          onSaved: (String age) {
                              setState(()=> _age = int.tryParse(age));
                          },
                          style: TextStyle(),
                          validator: numberValidator,
                          keyboardType: TextInputType
                              .number, // Use email input type for em
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ], // ails.
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: 'Sua idade')),
                      new Container(
                          padding: const EdgeInsets.fromLTRB(0,20,0,0),
                          child: new Text(
                          'Você procura por',
                          )),
                      
                      new Container(
                          padding: EdgeInsets.all(0),
                          child: new DropdownButton<String>(
                              value: _findPreference,
                              isExpanded: true,
                              elevation: 16,
                              onChanged: (String preference) {
                                  setState(()=>{_findPreference = preference});
                              },
                              items: <String>['Qualquer', 'Homens', 'Mulheres']
                                  .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                  );
                              })
                                  .toList(),
                          )),
                      new Container(
                          child: RaisedButton(
                              child: Text("Atualizar minha localização"),
                              onPressed: _updateLocation
                          ),
                      ),
                      new Container(
                          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
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
  int currentPageIndex = 0;
  Page1 page1;
  Configuration configuration;
  Widget currentPage;

  List<Widget> pages;

  @override
  void initState() {
    page1 = Page1();
    configuration = Configuration();
    pages = [page1, configuration];
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
