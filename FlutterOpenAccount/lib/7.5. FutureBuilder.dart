import 'package:flutter/material.dart';

class FutureBuilderApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
//      home: FutuerWidg(),
      home: StreamWdg(),
    );
  }
}

class FutuerWidg extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: FutureBuilder<String>(
          future: mockNetWorkData(),
          builder: (BuildContext contxt,AsyncSnapshot snapshot){
            // 请求已结束
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasError){
                // 请求失败，显示错误
                return Text("Error: ${snapshot.error}");
              } else {
                // 请求成功，显示数据
                return Text("Contents: ${snapshot.data}");
              }
            }else{// 请求未结束，显示loading
              // 请求未结束，显示loading
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

/*
* enum ConnectionState {
  /// 当前没有异步任务，比如[FutureBuilder]的[future]为null时
  none,

  /// 异步任务处于等待状态
  waiting,

  /// Stream处于激活状态（流上已经有数据传递了），对于FutureBuilder没有该状态。
  active,

  /// 异步任务已经终止.
  done,
}

ConnectionState.active只在StreamBuilder中才会出现。


*/
Future<String>mockNetWorkData() async{
  return Future.delayed(Duration(seconds: 2),() => "我是从互联网上获取的数据");
}



/*
*我们知道，在Dart中Stream 也是用于接收异步事件数据，和Future 不同的是，
* 它可以接收多个异步操作的结果，它常用于会多次读取数据的异步任务场景，如网络内容下载、文件读写等。
* StreamBuilder正是用于配合Stream来展示流上事件（数据）变化的UI组件。
* 下面看一下StreamBuilder的默认构造函数：
* */

Stream<int>counter(){
  return Stream.periodic(Duration(seconds: 1),(i){
    return i;
  });
}

class StreamWdg extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: counter(),
        builder: (BuildContext context,AsyncSnapshot<int>snapshot){
          if(snapshot.hasError)
            return Text("Error: ${snapshot.error}");
          switch(snapshot.connectionState){
            case ConnectionState.done:
              return Text("没有Stream");
            case ConnectionState.waiting:
              return Text("等待数据...");
            case ConnectionState.active:
              return Text("active: ${snapshot.data}");
            case ConnectionState.none:
              return Text("Stream已关闭");
          }
          return null;
        }
    );
  }
}




