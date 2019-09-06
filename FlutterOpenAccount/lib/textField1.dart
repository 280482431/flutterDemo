import 'package:flutter/material.dart';

class TextFieldApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "TextFieldApp",
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: TextFieldPage(),
    );
  }
}

class TextFieldPage extends StatefulWidget{
  TextFieldPage ({Key key}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _TextFieldPageState();
  }

//  _TextFieldPageState createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage>{
  String _errorText;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("TextField App"),
      ),
      body: Center(
        child: TextField(
          onSubmitted: (String text){
            setState(() {
              if(!isEmail(text)){
                _errorText = 'is not Email';
              }else{
                _errorText = null;
              }
            });
          },
          decoration: InputDecoration(hintText: "hintText",errorText: _getErrorText()),
        ),
      ),
    );
  }

  _getErrorText() {
    return _errorText;
  }

  bool isEmail(String text){
    String emailRegexp =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(emailRegexp);
    return regExp.hasMatch(text);
  }

}