import 'package:flutter/material.dart';

class SingleChildSCrollApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: SingleChildSCrollState(),
    );
  }
}

class SingleChildSCrollState extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    // TODO: implement build
    return Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: str.split("")
              //每一个字母都用一个Text显示,字体为原来的两倍
              .map((c) => Text(c,textScaleFactor: 2.0,))
              .toList(),
            ),
          ),
    ));
  }
}