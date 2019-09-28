import 'package:flutter/material.dart';

/***********************单例模式******************************/

//订阅者回调签名
typedef void EventCallback(arg);

/*
*  在Android原生中，有广播可以进行跨页面传递数据。
Flutter中我们可以自定义一个事件总线，实现跨页面传递数据。
步骤

定义一个单例类
添加一个Map<String ,CallBack>变量，保存监听的事件名和对应的回调方法。
添加on方法，用于向map中添加事件。
添加off方法，用于从map中移除事件监听。
定义emit方法，用于事件源发射事件。
*/

class EventBus{

  //私有构造函数
  EventBus._internal();

  //保存单例
  static EventBus _singleton = new EventBus._internal();

  //工厂构造函数
  factory EventBus() => _singleton;

  //保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
  var _emap = new Map<Object,List<EventCallback>>();

  //添加订阅者
  void on(eventName,EventCallback f){
    if(eventName == null || f == null)return;
    _emap[eventName] ??= new List<EventCallback>();
    _emap[eventName].add(f);
  }

  //移除订阅者
  void off(evenName,[EventCallback f]){
    var list =_emap[evenName];
    if(evenName==null||list==null)return;
    if(f==null){
      _emap[evenName] =null;
    }else{
      list.remove(f);
    }
  }

  //触发事件，事件触发后该事件所有订阅者会被调用
  void emit(eventName,[arg]){
    var list = _emap[eventName];
    if(list == null)return;
    int len = list.length-1;
    //反向遍历，防止在订阅者在回调中移除自身带来的下标错位
    for(var i=len;i>-1;--i){
      list[i](arg);
    }
  }
}

//定义一个top-level变量，页面引入该文件后可以直接使用bus
var bus = new EventBus();


/*********页面*************/

class EventBusTest extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "RaisedButton",
      home: MyHomePage(title: "RaisedButton",),
    );
  }
}

class MyHomePage extends StatefulWidget{
  MyHomePage({Key key,this.title}):super(key:key);

  final String title;
  @override
  _MyHomePageState createState()=>_MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
// 获取事件总线
  var bus = new EventBus();
  int index = 1;
  String text ="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 添加监听，模仿不同页面添加事件监听
    bus.on("key0", (parmas){text=parmas.toString();});
    bus.on("key1", (parmas){text=parmas.toString();});
    bus.on("key2", (parmas){text=parmas.toString();});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //widget关闭时 删除监听
    bus.off("key0");
    bus.off("key1");
    bus.off("key2");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("app Name"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: (){}),
        ],
      ),
      body: Center(child: Text(text),),
      floatingActionButton: FloatingActionButton(
          child: Text("emit"),
          onPressed: _onAdd),
    );
  }

  void _onAdd(){
    index++;
    setState(() {
      bus.emit(getNAmeByIndex(index),index);
    });
  }

  String getNAmeByIndex(index){
    switch(index%3){
      case 0:
        return "key0";
        break;
      case 1:
        return "key1";
        break;
      default:
        return "key2";
        break;
    }

//    if(index%3==0){
//      return "key0";
//    }else if(index%3==1){
//      return "key1";
//    }else{
//      return "key2";
//    }
  }

}
