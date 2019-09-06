import 'package:flutter/material.dart';
import 'dart:developer';
/*
最终代码
* void collectLog(String line){
    ... //收集日志
}
void reportErrorAndLog(FlutterErrorDetails details){
    ... //上报错误和日志逻辑
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack){
    ...// 构建错误信息
}

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    reportErrorAndLog(details);
  };
  runZoned(
    () => runApp(MyApp()),
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        collectLog(line); // 收集日志
      },
    ),
    onError: (Object obj, StackTrace stack) {
      var details = makeDetails(obj, stack);
      reportErrorAndLog(details);
    },
  );
}
*
* */
class DebugerLogApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Debugger',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes:{
        "new_route":(context)=>NewRoute(),
      },
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

//路由管理
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        // child: Text("This is new route"),
        child: Text(ModalRoute.of(context).settings.arguments),
      ),
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

  //debugger 编程式断点
  void someFunction(double offset) {
    //debugger 编程式断点
    debugger(when: offset > 30.0); //debugger 编程式断点
    // ...
    print('日志');
    debugPrint('如果你一次输出太多，那么Android有时会丢弃一些日志行。为了避免这种情况');
    /*
  ClassName(more information about this instance…)
    toStringDeep
    toString
    toStringShort
  */
    //assert
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
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            FlatButton(
              child: Text("open new route"),
              textColor: Colors.yellow,
              onPressed: (){
                // Navigator.pushNamed(context, "new_route");
                // Navigator.push(context, new MaterialPageRoute(builder: (context){
                //   return new NewRoute();
                // }));
                // Navigator.of(context).pushNamed("new_route", arguments: "hi");
                Navigator.of(context).pushNamed("new_route", arguments: "his is new route");
              },
            ),
            FlatButton(
              child: Text("Debbuger"),
              textColor: Colors.green,
              onPressed: (){
//                someFunction(0.0);
//                debugDumpApp();//Widget 层
//                debugDumpRenderTree();//渲染层
//                debugDumpLayerTree();//层

//                debugFillProperties(properties)//来添加信息

                /*
                *   要用SemanticsDebugger
                *   debugDumpSemanticsTree();//语义
                *   debugPrintBeginFrameBanner();//该标志用橙色或轮廓线标出每个层的边界
                *   debugPrintEndFrameBanner();//只要他们重绘时，这会使该层被一组旋转色所覆盖
                *
                *
                *   调试动画
                *   调试动画最简单的方法是减慢它们的速度。为此，请将timeDilation变量
                *   （在scheduler库中）设置为大于1.0的数字，例如50.0。 最好在应用程序启动时只设置一次。
                *   如果您在运行中更改它，尤其是在动画运行时将其值减小，则框架的观察时可能会倒退，
                *   这可能会导致断言并且通常会干扰您的工作。
                *
                *   调试性能问题
                *   要了解您的应用程序导致重新布局或重新绘制的原因，您可以分别设置debugPrintMarkNeedsLayoutStacks
                *   和 debugPrintMarkNeedsPaintStacks标志。 每当渲染盒被要求重新布局和重新绘制时，
                *   这些都会将堆栈跟踪记录到控制台。如果这种方法对您有用，您可以使用services库中的
                *   debugPrintStack()方法按需打印堆栈痕迹。
                *
                *   统计应用启动时间
                *    flutter run --trace-startup --profile
                *
               */

                try{
                  Timeline.startSync('interesting function');
                  Timeline.finishSync();
                }catch(e, stack){
                  print(e);
                }

              },
            )
//            RandomWordsWidget();
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//debugger 编程式断点
void someFunction111(double offset) {
  //debugger 编程式断点
  debugger(when: offset > 30.0);//debugger 编程式断点
  // ...
  print('日志');
  debugPrint('如果你一次输出太多，那么Android有时会丢弃一些日志行。为了避免这种情况');
  /*
  ClassName(more information about this instance…)
    toStringDeep
    toString
    toStringShort
  */
  //assert
}

////包管理
//class RandomWordsWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // 生成随机字符串
//    final wordPair = new WordPair.random();
//    return Padding(
//      padding: const EdgeInsets.all(8.0),
//      child: new Text(wordPair.toString()),
//    );
//  }
//}

