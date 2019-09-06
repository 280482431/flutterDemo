import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget{
  void _onPressed(){
    print('_onPressed');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('ButtonApp'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('RaisedButton'),
              onPressed: (){},
            ),
            FlatButton(
              child: Text('FlatButton'),
              onPressed: (){},
            ),
            OutlineButton(
              child: Text('OutlineButton'),
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: (){},
            ),
            RaisedButton.icon(
              icon: Icon(Icons.send),
              label: Text("发送"),
              onPressed: _onPressed,
            ),
            OutlineButton.icon(
              icon: Icon(Icons.add),
              label: Text("添加"),
              onPressed: _onPressed,
            ),
            FlatButton.icon(
              icon: Icon(Icons.info),
              label: Text("详情"),
              onPressed: _onPressed,
            ),
            FlatButton(
              color: Colors.teal,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text('Submit'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              onPressed: (){},
            )
          ],
        ),
      ),
    );
  }
}