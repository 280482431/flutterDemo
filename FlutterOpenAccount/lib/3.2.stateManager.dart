import 'package:flutter/material.dart';

class StateManager extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(//App
      title: "title",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TapboxA(),
    );


//    return new TapboxA();//Widgt

    return Scaffold(//Scaffold
      appBar: AppBar(
        title: Text("title"),
      ),
        body: Center(
          child: new TapboxA(),
//          child:ParentWidget(),
//          child:ParentWidgetC(),
        )
    );
  }
}

// TapboxA 管理自身状态.

//------------------------- TapboxA ----------------------------------

class TapboxA extends StatefulWidget{
   TapboxA({Key key}) : super(key: key);

  @override
  _TapboxAState createState() => new _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}
// ParentWidget 为 TapboxB 管理状态.

//------------------------ ParentWidget --------------------------------

class ParentWidget extends StatefulWidget{
  @override
  _ParentWidgetState createState() => new _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget>{
  bool _active = false;

  void _handleTapboxChanged(bool newValue){
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new TapboxB(//创建并传值
        active : _active,
        onChange:_handleTapboxChanged,
      ),
    );
  }
}

//------------------------- TapboxB ----------------------------------

class TapboxB extends StatelessWidget{
  //接收传递的值
  TapboxB({Key key, this.active:false, @required this.onChange}):super(key:key);

  final bool active;
  final ValueChanged<bool> onChange;

  void _handleTap(){
    onChange(!active);
  }

  Widget build(BuildContext context){
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//---------------------------- ParentWidget ----------------------------

class ParentWidgetC extends StatefulWidget{
  @override
  _ParentWidgetCState createState() => new _ParentWidgetCState();
}

class _ParentWidgetCState extends State<ParentWidgetC>{
  bool _atcive = false;

  void _handleTapboxChanged(bool newValue){
    setState(() {
      _atcive = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new TapboxC(
          active: _atcive,
          onChange: _handleTapboxChanged),
    );
  }
}

//----------------------------- TapboxC ------------------------------

class TapboxC extends StatefulWidget{
  TapboxC({Key key, this.active:false, @required this.onChange}):super(key:key);

  final bool active;
  final ValueChanged<bool> onChange;

  @override
  _TapboxCState createState() => new _TapboxCState();

}

class _TapboxCState extends State<TapboxC>{
  bool _highlight =false;

  void _handleTapDown(TapDownDetails details){
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel(){
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap(){
    widget.onChange(!widget.active);
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: new Container(
        child: Center(
          child: Text(widget.active?'Active' : 'Inactive',
              style: new TextStyle(fontSize: 32.0,color: Colors.white)),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: widget.active?Colors.lightGreen[700]:Colors.grey[600],
          border: _highlight?new Border.all(
            color: Colors.teal[700],
            width: 10.0,
          )
              :null,
        ),
      ),
    );
  }
}