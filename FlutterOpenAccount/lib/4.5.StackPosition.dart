import 'package:flutter/material.dart';

class StackPositionApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Stack和绝对定位"),
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            alignment: Alignment.center,//指定未定位或部分定位widget的对齐方式
            fit: StackFit.expand, //未定位widget占满Stack整个空间
            children: <Widget>[
              Positioned(left: 18.0,child: Text("I am Jack额度",style: TextStyle(backgroundColor: Colors.red))),
              Container(child: Text("Hello world",style: TextStyle(color: Colors.cyan),),
              color: Colors.amber,),
              Positioned(left: 18.0,child: Text("I am Jack",style: TextStyle(backgroundColor: Colors.red))),
              Positioned(top: 18.0,child: Text("Your friend",style: TextStyle(backgroundColor: Colors.green),)),
            ],
          ),
        ),
      ),
    );
  }
}

/*
* alignment：此参数决定如何去对齐没有定位（没有使用Positioned）或部分定位的子组件。
* 所谓部分定位，在这里特指没有在某一个轴上定位：left、right为横轴，top、bottom为纵轴，
* 只要包含某个轴上的一个定位属性就算在该轴上有定位。
*
* textDirection：和Row、Wrap的textDirection功能一样，都用于确定alignment对齐的参考系，
* 即：textDirection的值为TextDirection.ltr，则alignment的start代表左，end代表右，
* 即从左往右的顺序；textDirection的值为TextDirection.rtl，则alignment的start代表右，
* end代表左，即从右往左的顺序。
*
fit：此参数用于确定没有定位的子组件如何去适应Stack的大小。StackFit.loose表示使用子组件的大小，
StackFit.expand表示扩伸到Stack的大小。

overflow：此属性决定如何显示超出Stack显示空间的子组件；值为Overflow.clip时，
超出部分会被剪裁（隐藏），值为Overflow.visible 时则不会。
* */

