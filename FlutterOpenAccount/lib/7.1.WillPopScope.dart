import 'package:flutter/material.dart';
/*
* 为了避免用户误触返回按钮而导致APP退出，在很多APP中都拦截了用户点击返回键的按钮，
* 然后进行一些防误触判断，比如当用户在某一个时间段内点击两次时，才会认为用户是要退出（而非误触）。
* Flutter中可以通过WillPopScope来实现返回按钮拦截

* */
class WillPopScopeApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: WillPopScopeTestRoute(),
      ),
    );
  }
}

/*
* onWillPop是一个回调函数，当用户点击返回按钮时被调用（包括导航返回按钮及Android物理返回按钮）。
* 该回调需要返回一个Future对象，如果返回的Future最终值为false时，则当前路由不出栈(不会返回)；
* 最终值为true时，当前路由出栈退出。我们需要提供这个回调来决定是否退出。

*/

class WillPopScopeTestRoute extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WillPopScopeTestRouteState();
  }
}

class WillPopScopeTestRouteState extends State<WillPopScopeTestRoute>{
  DateTime _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: Container(alignment: Alignment.center,
          child: Text("1秒内连续按两次返回键退出"),),
        onWillPop: ()async{
          if(_lastPressedAt==null||DateTime.now().difference(_lastPressedAt)>
              Duration(seconds: 1)){
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        });
  }
}


