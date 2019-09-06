import 'package:flutter/material.dart';
import 'Regist.dart';

class PrepareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(ModalRoute
            .of(context)
            .settings
            .arguments),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}