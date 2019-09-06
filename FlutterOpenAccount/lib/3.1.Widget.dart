import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//
class Wdg extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
//        home:new Echo(text: "hello world"),
//      home: new ContextRoute(),
//      home: new CounterWidget(),
//      home:Text("hao") ,
//      home: ContextState1(),
      home: Cupertino1(),
    );
  }
}

//StatelessWidget 无状态Widget
class Echo extends StatelessWidget {
  const Echo({
    Key key,
    @required this.text,
    this.backgroundColor:Colors.grey,
  }):super(key:key);

  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}

//BuildContext内容
class ContextRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("测试"),
      ),
      body: Container(
        child: Builder(builder: (context){
          // 在Widget树中向上查找最近的父级`Scaffold` widget
          Scaffold scanf = context.ancestorWidgetOfExactType(Scaffold);
          // 直接返回 AppBar的title， 此处实际上是Text("Context测试")
          return(scanf.appBar as AppBar).title;
      }),
      ),
    );
  }
}

//StatefulWidget（有状态Widge） 中创建state
class CounterWidget extends StatefulWidget{
  const CounterWidget({
    Key key,
    this.initValue:0
  });
  final int initValue;
  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}

//state生命周期
class _CounterWidgetState extends State<CounterWidget>{
  int _counter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _counter = widget.initValue;
    print("initState");

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text("$_counter"),
          onPressed: ()=>setState(()=>++_counter,
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

}

//通过context获取state
class ContextState1 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("子树中获取State对象"),
      ),
      body: Center(
        child: Builder(builder: (context){
          return RaisedButton(
              onPressed: (){
                // 查找父级最近的Scaffold对应的ScaffoldState对象
            ScaffoldState _state = context.rootAncestorStateOfType(
              TypeMatcher<ScaffoldState>());
            //调用ScaffoldState的showSnackBar来弹出SnackBar
            _state.showSnackBar(
              SnackBar(
                  content: Text("我是SnackBar")
              ),
            );
          },
            child: Text("显示SnackBar"),
          );
        }),
      ),
    );
  }
}

class Cupertino1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cupertino"),
      ),
        child: Center(
        child: CupertinoButton(
          color: CupertinoColors.activeBlue,
            child: Text("CupertinoButton"),
            onPressed: null),
    ));
  }
}