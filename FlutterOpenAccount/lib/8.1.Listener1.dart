import 'package:flutter/material.dart';

/*
*Flutter中的手势系统有两个独立的层。第一层为原始指针(pointer)事件，它描述了屏幕上指针
* （例如，触摸、鼠标和触控笔）的位置和移动。 第二层为手势，描述由一个或多个指针移动组成的语义动作，
* 如拖动、缩放、双击等。本章将先分别介绍如何处理这两种事件，
* 最后再介绍一下Flutter中重要的Notification机制。
* */

/*
*在移动端，各个平台或UI系统的原始指针事件模型基本都是一致，即：一次完整的事件分为三个阶段：
* 手指按下、手指移动、和手指抬起，而更高级别的手势（如点击、双击、拖动等）都是基于这些原始事件的。

当指针按下时，Flutter会对应用程序执行命中测试(Hit Test)，以确定指针与屏幕接触的位置存在哪些组件
（widget）， 指针按下事件（以及该指针的后续事件）然后被分发到由命中测试发现的最内部的组件，
然后从那里开始，事件会在组件树中向上冒泡，这些事件会从最内部的组件被分发到组件树根的路径上的所有组件，
这和Web开发中浏览器的事件冒泡机制相似， 但是Flutter中没有机制取消或停止“冒泡”过程，
而浏览器的冒泡是可以停止的。注意，只有通过命中测试的组件才能触发事件。

Flutter中可以使用Listener来监听原始触摸事件，按照本书对组件的分类，则Listener也是一个功能性组件。
下面是Listener的构造函数定义：

Listener({
  Key key,
  this.onPointerDown, //手指按下回调
  this.onPointerMove, //手指移动回调
  this.onPointerUp,//手指抬起回调
  this.onPointerCancel,//触摸事件取消回调
  this.behavior = HitTestBehavior.deferToChild, //在命中测试期间如何表现
  Widget child
})
* */

/*
* position：它是鼠标相对于当对于全局坐标的偏移。
delta：两次指针移动事件（PointerMoveEvent）的距离。
pressure：按压力度，如果手机屏幕支持压力传感器(如iPhone的3D Touch)，此属性会更有意义，
如果手机不支持，则始终为1。
orientation：指针移动方向，是一个角度值。
*
*deferToChild：子组件会一个接一个的进行命中测试，如果子组件中有测试通过的，则当前组件通过，
* 这就意味着，如果指针事件作用于子组件上时，其父级组件也肯定可以收到该事件。

opaque：在命中测试时，将当前组件当成不透明处理(即使本身是透明的)，最终的效果相当于
当前Widget的整个区域都是点击区域。
*
*translucent：当点击组件透明区域时，可以对自身边界内及底部可视区域都进行命中测试，
* 这意味着点击顶部组件透明区域时，顶部组件和底部组件都可以接收到事件
* */

class Listener1App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Listener1App"),
        ),
        body: Stack(
          children: <Widget>[
            Listener(
              child: ConstrainedBox(
                constraints: BoxConstraints.tight( Size(300.00,200.00)),
                child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.blue)),
              ),
              onPointerDown: (event) => print("down0"),
            ),
            Listener(
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(200, 100)),
                child: Center(
                  child: Text("左上角200*100范围内非文本区域点击"),),
              ),
              onPointerDown: (event) => print("down1"),
              //behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
            ),
            Listener(
              child: AbsorbPointer(//忽略PointerEvent IgnorePointer和AbsorbPointer
                /*
                * 用IgnorePointer和AbsorbPointer，这两个组件都能阻止子树接收指针事件，
                * 不同之处在于AbsorbPointer本身会参与命中测试，而IgnorePointer本身不会参与，
                * 这就意味着AbsorbPointer本身是可以接收指针事件的(但其子树不行)，
                * 而IgnorePointer不可以
                * */
                child: Listener(
                  child: Container(
                    color: Colors.red,
                    width: 200,
                    height: 100,
                  ),
                  onPointerDown: (event) => print("in"),
                ),
              ),
              onPointerDown: (event) => print("up"),
            ),
          ],
        ),
      ),
    );
  }
}



