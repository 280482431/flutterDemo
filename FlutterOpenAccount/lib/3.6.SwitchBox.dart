import 'package:flutter/material.dart';

class SwitchCheckBoxApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    return Scaffold(
//      body: Center(
//        child: new SwitchAndCheckBoxTestRoute(),
//      )
//    );
//    return MaterialApp(
//      title: 'title',
//      home: new SwitchCheckBox(),
//    );
    return MaterialApp(//为什么要同时包裸MaterialApp和Scaffold
      home: Scaffold(
        body:Center(
          child: SwitchCheckBox(),
        ),
      ),
    );
  }
}

class SwitchCheckBox extends StatefulWidget {
  SwitchCheckBox({Key key}) :super(key : key);
  @override
  _SwitchCheckBoxState createState() => new _SwitchCheckBoxState();
}

class _SwitchCheckBoxState extends State<SwitchCheckBox> {
  bool _switchSelected=true; //维护单选开关状态
  bool _checkboxSelected=true;//维护复选框状态
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
          value: _switchSelected,//当前状态
          onChanged:(value){
            //重新构建页面
            setState(() {
              _switchSelected=value;
            });
          },
        ),
        Checkbox(
          value: _checkboxSelected,
          activeColor: Colors.red, //选中时的颜色
          onChanged:(value){
            setState(() {
              _checkboxSelected=value;
            });
          } ,
        )
      ],
    );
  }
}

//----------------------------- SwitchDemo ------------------------------

class SwitchDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SwitchDemo();
}

class _SwitchDemo extends State<SwitchDemo> {
  bool _value = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Switch(
          value: _value,
          onChanged: (newValue) {
            setState(() {
              _value = newValue;
            });
          },
          activeColor: Colors.red,
          activeTrackColor:Colors.black,
          inactiveThumbColor:Colors.green,
          inactiveTrackColor: Colors.blue,
          activeThumbImage: AssetImage(
            'images/1.png',
          ),
        ),
      ],
    );
  }
}