import 'package:flutter/material.dart';
import 'Prepare.dart';

void main() => runApp(new SelectAreaApp());

class SelectAreaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '国都开户',
      theme: new ThemeData(
        primarySwatch:Colors.blueGrey,
      ),
      routes:{
        "prepare_route":(context)=>PrepareRoute(),
        "person_route":(context)=>PersonRoute(),
      },
      home: new MyHomePage(title: '选择地区'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // new Image(image: AssetImage("graphics/CHN.png")),
          children: <Widget>[
            new Image(image: AssetImage("graphics/CHN.png"),
//              onTap:(){
//
//                }
            ),

            new Image(image: AssetImage("graphics/HK.png")),
//            new IconButton(
//              icon: ImageIcon(AssetImage("graphics/CHN.png")),
//              onPressed: (){
//                Navigator.of(context).pushNamed("prepare_route",arguments: "准备开户");
//              },
//            ),

//            new IconButton(
//              icon: ImageIcon(AssetImage("graphics/HK.png")),
//              onPressed: (){
//                Navigator.of(context).pushNamed("person_route",arguments: "准备开户");
//              },
//            ),
          ],
        ),
      ),
    );
  }
}

//路由管理
class PrepareRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrepareApp();
  }
}

class PersonRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人资料"),
      ),
      body: Center(
        // child: Text("This is new route"),
        child: Text(ModalRoute
            .of(context)
            .settings
            .arguments),
      ),
    );
  }
}