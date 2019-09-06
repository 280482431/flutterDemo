import 'package:flutter/material.dart';

class ClipApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: ClipTestRoute(),
    );
  }
}

class ClipTestRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // Image
    Widget avatar = Image.asset("graphics/HK.png",width: 60.0,);
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            avatar,//不剪裁
            ClipOval(child: avatar,),//剪裁为圆形
            ClipRRect(//剪裁为圆角矩形
              borderRadius: BorderRadius.circular(5.0),
              child: avatar,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5,//宽度设为原来宽度一半，另一半会溢出
                  child: avatar,
                ),
                Text("你好世界",style: TextStyle(color: Colors.blue),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRect(//将溢出部分剪裁
                  child: Align(
                    alignment: Alignment.center,
                    widthFactor: .5,//宽度设为原来宽度一半
                    child: avatar,
                ),
              ),
                Text("你好世界",style: TextStyle(color: Colors.blue),)
              ],
            ),
            Row(
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(
                  color: Colors.red
                  ),
                  child: ClipRect(
                    clipper: MyClipper(),
                    child: avatar,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*
* getClip()是用于获取剪裁区域的接口，由于图片大小是60×60，
* 我们返回剪裁区域为Rect.fromLTWH(10.0, 15.0, 40.0, 30.0)，及图片中部40×30像素的范围。
shouldReclip() 接口决定是否重新剪裁。如果在应用中，剪裁区域始终不会发生变化时应该返回false，
这样就不会触发重新剪裁，避免不必要的性能开销。如果剪裁区域会发生变化（比如在对剪裁区域执行一个动画），
那么变化后应该返回true来重新执行剪裁。
*/
class MyClipper extends CustomClipper<Rect>{
  @override
  Rect getClip(Size size) => Rect.fromLTWH(10.0, 15.0, 10.0, 20.0);

  @override
  bool shouldReclip(CustomClipper<Rect> oldCliper) => false;
}

/*
* 可以看到我们的剪裁成功了，但是图片所占用的空间大小仍然是60×60（红色区域），
* 这是因为剪裁是在layout完成后的绘制阶段进行的，所以不会影响组件的大小，
* 这和Transform原理是相似的。
* */