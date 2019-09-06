import 'package:flutter/material.dart';

/*
* 4.6.2 Align和Stack对比
*
可以看到，Align和Stack/Positioned都可以用于指定子元素相对于父元素的偏移，
但它们还是有两个主要区别：

1。定位参考系统不同；Stack/Positioned定位的的参考系可以是父容器矩形的四个顶点；
而Align则需要先通过alignment 参数来确定坐标原点，不同的alignment会对应不同原点，
最终的偏移是需要通过alignment的转换公式来计算出。
2。Stack可以有多个子元素，并且子元素可以堆叠，而Align只能有一个子元素，不存在堆叠。
*/

/*
* 总结

本节重点介绍了Align组件及两种偏移类Alignment 和FractionalOffset，读者需要理解这两种偏移类的区别及各自的坐标转化公式。另外，在此建议读者在需要制定一些精确的偏移时应优先使用FractionalOffset，因为它的坐标原点和布局系统相同，能更容易算出实际偏移。

在后面，我们又介绍了Align组件和Stack/Positioned、Center的关系，读者可以对比理解。

还有，熟悉Web开发的同学可能会发现Align组件的特性和Web开发中相对定位（position: relative）非常像，是的！在大多数时候，我们可以直接使用Align组件来实现Web中相对定位的效果，读者可以类比记忆。

*/

class StackAlignApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
//      home: new Align1(),
      home: new Align2(),
    );
  }
}

class Align2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("对齐与相对定位（Align）"),
        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    height: 120.0,
                    width: 120.0,
                    color: Colors.blue[50],
                    child:Align(
                      alignment: Alignment.topRight,
                      child: FlutterLogo(
                        size: 60.0,
                        colors: Colors.red,
                      ),
                    )
                ),
                Container(
                  height: 120,
                  width: 120,
                  color: Colors.green[50],
                  child: Align(
                    //因为FlutterLogo的宽高为60，则Align的最终宽高都为2*60=120。
                    widthFactor: 2,
                    heightFactor: 2,
//          alignment: Alignment.topRight,//右上对齐
                    alignment: Alignment(1.0, 0.0),//60+1*30
                    child: FlutterLogo(
                      colors: Colors.red,
                      size: 60.0,
                    ),
                  ),
                ),

              ],
            ),

            Row(
              children: <Widget>[
                Container(
                  height: 120,
                  width: 120,
                  color: Colors.green[50],
                  child: Align(
                    //因为FlutterLogo的宽高为60，则Align的最终宽高都为2*60=120。
                    widthFactor: 2,
                    heightFactor: 2,
//          alignment: Alignment.topRight,//右上对齐
                    alignment: Alignment(0.0, 0.0),//以矩形的中心点作为坐标原点，
                    child:  FlutterLogo(
                      size: 60.0,
                      colors: Colors.red,
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 120,
                  color: Colors.blue[50],
                  child: Align(
                    widthFactor: 2,
                    heightFactor: 2,
                    alignment: Alignment(1, 1),//以中心为原点，1为边缘坐标
                    child: Container(
                      height: 60,
                      width: 60,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: <Widget>[
                Container(
                  height: 120,
                  width: 120,
                  color: Colors.green[50],
                  child: Align(
                    alignment: FractionalOffset(0.0, 0.0),//左上为原点
                    child: FlutterLogo(
                      size: 60,
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 120,
                  color: Colors.green[50],
                  child: Align(
                    alignment: FractionalOffset(1.0, 1.0),//1，1为右下
                    child: FlutterLogo(
                      size: 60,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                DecoratedBox(decoration: BoxDecoration(color: Colors.blue),
                  child: Center(
                    child: Text("xxx"),
                  ),
                ),
                DecoratedBox(decoration: BoxDecoration(color: Colors.green),
                  child: Center(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: Text("ooo"),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}