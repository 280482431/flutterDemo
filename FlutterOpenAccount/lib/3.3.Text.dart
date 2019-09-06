import 'package:flutter/material.dart';

class TextApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: 'TextApp',
        home://1.设置文本默认样式
        DefaultTextStyle(style: TextStyle(color: Colors.teal,fontSize: 10.0), child:
        Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('1.Hello world',textAlign: TextAlign.right,),
              new Text('2.Hello world'*4,maxLines: 1,overflow: TextOverflow.clip,),
              new Text('3.Hello world',textScaleFactor: 1.5,),
              new Text('4.Hello world',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18.0,
                  height: 1.2,
                  fontFamily: "Courier",
                  background: new Paint()..color=Colors.teal,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dashed,
                ),),
              Text.rich(TextSpan(
                  children: [
                    TextSpan(
                      text: 'Home',
                    ),
                    TextSpan(
                      text: 'http://www.',
                      style: TextStyle(color: Colors.teal),
//                    recognizer: _tapRecognizer
                    )
                  ]
              ))
            ],
          ),
        ),
        )
    );
  }
}

