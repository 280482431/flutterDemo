import 'package:flutter/material.dart';

class ProgressApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "progressApp",
      home: ProgressFull(),
    );
  }
}

class ProgressFull extends StatefulWidget{
  @override
  ProgressState createState() => ProgressState();
}

class ProgressState extends State<ProgressFull> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  
  @override
  void initState() {
    // TODO: implement initState
    _animationController = new AnimationController(vsync: this,duration: Duration(seconds: 3));
    _animationController.forward();
    _animationController.addListener(() => setState(() => {
      print("ctl监听")
    }));//增加监听

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();//移除
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: ColorTween(begin: Colors.grey,end: Colors.blue).animate(_animationController),
              value: _animationController.value,
            ),
          ),
          LinearProgressIndicator(// 模糊进度条(会执行一个动画)
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
          LinearProgressIndicator(//进度条显示50%
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            value: .5,//进度条显示50%
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            value: .5,
          ),
          SizedBox(
            height: 3,
            child: LinearProgressIndicator(//进度条显示50%
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: .5,//进度条显示50%
            )
          ),
          SizedBox(
            height: 100,
            width: 150,
            child: CircularProgressIndicator(//椭圆
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: .5,
            ),
          ),
        ],
      ),
    );
  }
}