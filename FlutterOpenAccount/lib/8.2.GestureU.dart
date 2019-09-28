import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';

class GetstureApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("GetstureDetector"),
        ),
//        body: GestureDetectorTestRoute(),//手势
//        body: _Drag(),//拖动
//      body: _DragVertical(),//单一方向拖动
//      body:_ScaleTestRoute() ,//缩放
//        body: _GestureRecognizerTestRoute(),//字变色
//        body: BothDirectionTestRoute(),//手势竞争
      body: GestureConflictTestRoute(),//手势冲突
      ),
    );
  }
}

/***************手势******************/

class GestureDetectorTestRoute extends StatefulWidget{
  @override
  _GestureDetectorTestRouteState createState() => _GestureDetectorTestRouteState();
}

class _GestureDetectorTestRouteState extends State<GestureDetectorTestRoute>{
  String _operation = "No Gesture detected!";//保存事件名
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 200,
          height: 100,
          child: Text(_operation,style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () => updateText("Tap"),//点击
        onDoubleTap: () => updateText("onDoubleTap"),//双击
        onLongPress: () => updateText("onLongPress"),//长按
      ),
    );
  }
  void updateText(String text){
    setState(() {
      _operation = text;
    });
  }
}

/******************拖动***************/

class _Drag extends StatefulWidget{
  @override
  _DragState createState ()=> _DragState();
}

class _DragState extends State<_Drag>{
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(child: Text("A"),),
              //手指按下时会触发此回调
              onPanDown: (DragDownDetails e){
                //打印手指按下的位置(相对于屏幕)
                print("用户手指按下：${e.globalPosition}");
              },
              // //手指滑动时会触发此回调
              onPanUpdate: (DragUpdateDetails e){
                //用户手指滑动时，更新偏移，重新构建
                setState(() {
                  _left += e.delta.dx;
                  _top += e.delta.dy;
                });
              },
              onPanEnd: (DragEndDetails e){
                print(e.velocity);
              },
        )),
      ],
    );
  }
}

/******************单一方向拖动***************/

class _DragVertical extends StatefulWidget{
  @override
  _DragVerticalState createState()=>_DragVerticalState();
}

class _DragVerticalState extends State<_DragVertical>{
  double _top = 0.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
     children: <Widget>[
       Positioned(
         top: _top,
           child: GestureDetector(
             child: CircleAvatar(child: Text("B"),),
             onVerticalDragUpdate: (DragUpdateDetails details){
               setState(() {
                 _top += details.delta.dy;
               });
             },
       )),
     ],
    );
  }
}

/*****************缩放****************/

class _ScaleTestRoute extends StatefulWidget{
  _ScaleTestRouteState createState () =>_ScaleTestRouteState();
}

class _ScaleTestRouteState extends State<_ScaleTestRoute>{
  double _width = 200.0;//通过修改图片宽度来达到缩放效果
  double _height = 200;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: GestureDetector(
        child: Image.asset("graphics/HK.png",width: _width,height: _height,),
        onScaleUpdate: (ScaleUpdateDetails details){
          setState(() {
            //缩放倍数在0.8到10倍之间
            _width = 200 *details.scale.clamp(.1, 10.0);
            _height = 200 *details.scale.clamp(.1, 10.0);
          });
        },
      ),
    );
  }
}

/***************8.2.2 GestureRecognizer***************/

/*
* 假设我们要给一段富文本（RichText）的不同部分分别添加点击事件处理器，
* 但是TextSpan并不是一个widget，这时我们不能用GestureDetector，
* 但TextSpan有一个recognizer属性，它可以接收一个GestureRecognizer。
* */

class _GestureRecognizerTestRoute extends StatefulWidget{
  @override
  _GestureRecognizerTestRouteState createState()=>_GestureRecognizerTestRouteState();
}

class _GestureRecognizerTestRouteState extends State<_GestureRecognizerTestRoute>{
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false;//变色开关

  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: "你好世界"),
            TextSpan(
              text: "点我变色",
              style: TextStyle(
                fontSize: 30.0,
                color: _toggle?Colors.blue:Colors.red
              ),
              recognizer: _tapGestureRecognizer
              ..onTap=(){
                setState(() {
                  _toggle = !_toggle;
                });
              }
            ),
            TextSpan(text:"你好世界"),
          ]
        )
      ),
    );
  }
}

/***************8.2.3 手势竞争与冲突***************/

/*
* 竞争

如果在上例中我们同时监听水平和垂直方向的拖动事件，那么我们斜着拖动时哪个方向会生效？
实际上取决于第一次移动时两个轴上的位移分量，哪个轴的大，哪个轴在本次滑动事件竞争中就胜出。
实际上Flutter中的手势识别引入了一个Arena的概念，Arena直译为“竞技场”的意思，
每一个手势识别器（GestureRecognizer）都是一个“竞争者”（GestureArenaMember），
当发生滑动事件时，他们都要在“竞技场”去竞争本次事件的处理权，而最终只有一个“竞争者”会胜出(win)。
例如，假设有一个ListView，它的第一个子组件也是ListView，如果现在滑动这个子ListView，
父ListView会动吗？答案是否定的，这时只有子ListView会动，
因为这时子ListView会胜出而获得滑动事件的处理权。
*/

class BothDirectionTestRoute extends StatefulWidget{
  @override
  BothDirectionTestRouteState createState()=>BothDirectionTestRouteState();
}

class BothDirectionTestRouteState extends State<BothDirectionTestRoute>{
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(child: Text("A"),),
              //垂直方向拖动事件
              onVerticalDragUpdate: (DragUpdateDetails details){
                setState(() {
                  _top += details.delta.dy;
                });
              },
              onHorizontalDragUpdate: (DragUpdateDetails details){
                _left += details.delta.dx;
              },
        )),
      ],
    );
  }

}

/*
* 手势冲突

由于手势竞争最终只有一个胜出者，所以，当有多个手势识别器时，可能会产生冲突。假设有一个widget，
它可以左右拖动，现在我们也想检测在它上面手指按下和抬起的事件，
* */

class GestureConflictTestRoute extends StatefulWidget{
  @override
  GestureConflictTestRouteState createState()=>GestureConflictTestRouteState();
}

class GestureConflictTestRouteState extends State<GestureConflictTestRoute>{
  double _left =0.0;
  double _leftB = 0.0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
//        Positioned(
//          left: _left,
//            child: GestureDetector(
//              child: CircleAvatar(child: Text("A"),),
//              onHorizontalDragUpdate: (DragUpdateDetails details){
//                setState(() {
//                  _left += details.delta.dx;
//                });
//              },
//              onHorizontalDragEnd: (details){
//                print("onHorizontalDragEnd");
//              },
//              onTapDown: (details){
//                print("down");
//              },
//              onTapUp: (details){
//                print("up");
//              },
//        )),
        //手势冲突只是手势级别的，而手势是对原始指针的语义化的识别，所以在遇到复杂的冲突场景时，
        // 都可以通过Listener直接识别原始指针事件来解决冲突。
        Positioned(
          top: 80.0,
            left: _leftB,
            child: Listener(
              onPointerDown: (details){
                print("down");
              },
              onPointerUp: (details){
                //会触发
                print("up");
              },
              child: GestureDetector(
                child: CircleAvatar(child: Text("B"),),
                onVerticalDragUpdate: (DragUpdateDetails details){
                  setState(() {
                    _leftB += details.delta.dy;
                  });
                },
                onVerticalDragEnd: (details){
                  print("onVerticalDragEnd");
                },
              ),
        )),
      ],
    );
  }
}

/*
* 我们发现没有打印"up"，这是因为在拖动时，刚开始按下手指时在没有移动时，拖动手势还没有完整的语义，
* 此时TapDown手势胜出(win)，此时打印"down"，而拖动时，拖动手势会胜出，当手指抬起时，
* onHorizontalDragEnd 和 onTapUp发生了冲突，但是因为是在拖动的语义中，
* 所以onHorizontalDragEnd胜出，所以就会打印 “onHorizontalDragEnd”。如果我们的代码逻辑中，
* 对于手指按下和抬起是强依赖的，比如在一个轮播图组件中，我们希望手指按下时，暂停轮播，
* 而抬起时恢复轮播，但是由于轮播图组件中本身可能已经处理了拖动手势（支持手动滑动切换），
* 甚至可能也支持了缩放手势，这时我们如果在外部再用onTapDown、onTapUp来监听的话是不行的。
* 这时我们应该怎么做？其实很简单，通过Listener监听原始指针事件就行：
* */



