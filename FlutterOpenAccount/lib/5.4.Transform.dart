import 'package:flutter/material.dart';

import 'dart:math' as math;

/*
* Transform的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段，所以无论对子组件应用何种变化，
* 其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。
* */

class TransformApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(""),
        ),
        body:  Column(
          children: <Widget>[

            Row(children: <Widget>[
              Container(
                color: Colors.black,
                child: new Transform(
                  alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
                  transform: new Matrix4.skewY(0.3),//沿Y轴倾斜0.3弧度
                  child: new Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.deepOrange,
                    child: const Text("Apartment for rent!"),
                  ),
                ),
              ),
              DecoratedBox(decoration: BoxDecoration(color: Colors.blue),
                child: Transform.translate(
                  offset: Offset(20.0, 10.0),
                  child: Text("Hello world"),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.green),
                child: Transform.rotate(angle: math.pi/2,
                  child: Text("Hello world"),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.scale(scale: 0.5,child: Text("Hello world"),
                ),
              ),
            ],),

            /*
            *由于第一个Text应用变换(放大)后，其在绘制时会放大，但其占用的空间依然为红色部分，
            * 所以第二个Text会紧挨着红色部分，最终就会出现文字重合。

由于矩阵变化只会作用在绘制阶段，所以在某些场景下，在UI需要变化时，
可以直接通过矩阵变化来达到视觉上的UI改变，而不需要去重新触发build流程，这样会节省layout的开销，
所以性能会比较好。如之前介绍的Flow组件，它内部就是用矩阵变换来更新UI，除此之外，
Flutter的动画组件中也大量使用了Transform以提高性能。
            * */
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(decoration: BoxDecoration(color: Colors.blue),
                  child: Transform.scale(
                    scale: 1.5,child: Text("Hello world"),),
                ),
                Text("你好",style: TextStyle(color: Colors.green,fontSize: 18.0),)
              ],
            ),

            /*
            * 由于RotatedBox是作用于layout阶段，所以子组件会旋转90度（而不只是绘制的内容），
            * decoration会作用到子组件所占用的实际空间上，所以最终就是上图的效果，
            * 读者可以和前面Transform.rotate示例对比理解。
            * */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(//将Transform.rotate换成RotatedBox
                  decoration: BoxDecoration(color: Colors.red),
                  child: RotatedBox(
                    quarterTurns: 1,//旋转90度(1/4圈)
                    child: Text("Hello world"),
                  ),
                ),
                Text("你好",style: TextStyle(color: Colors.green,fontSize: 18.0),),
              ],
            ),


          ],
        ),
      ),
    );
  }
}