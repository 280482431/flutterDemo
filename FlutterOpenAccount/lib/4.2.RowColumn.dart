import 'package:flutter/material.dart';

/*
*textDirection：表示水平方向子组件的布局顺序(是从左往右还是从右往左)，
* 默认为系统当前Locale环境的文本方向(如中文、英语都是从左往右，而阿拉伯语是从右往左)。
*
mainAxisSize：表示Row在主轴(水平)方向占用的空间，默认是MainAxisSize.max，
表示尽可能多的占用水平方向的空间，此时无论子widgets实际占用多少水平空间
，Row的宽度始终等于水平方向的最大宽度；而MainAxisSize.min表示尽可能少的占用水平空间，
当子组件没有占满水平剩余空间，则Row的实际宽度等于所有子组件占用的的水平空间；

mainAxisAlignment：表示子组件在Row所占用的水平空间内对齐方式，
如果mainAxisSize值为MainAxisSize.min，则此属性无意义，因为子组件的宽度等于Row的宽度。
只有当mainAxisSize的值为MainAxisSize.max时，此属性才有意义，
MainAxisAlignment.start表示沿textDirection的初始方向对齐，
如textDirection取值为TextDirection.ltr时，则MainAxisAlignment.start表示左对齐，
textDirection取值为TextDirection.rtl时表示从右对齐。而MainAxisAlignment.end和
MainAxisAlignment.start正好相反；MainAxisAlignment.center表示居中对齐。
读者可以这么理解：textDirection是mainAxisAlignment的参考系。

verticalDirection：表示Row纵轴（垂直）的对齐方向，默认是VerticalDirection.down
，表示从上到下。

crossAxisAlignment：表示子组件在纵轴方向的对齐方式，Row的高度等于子组件中最高的子元素高度，
它的取值和MainAxisAlignment一样(包含start、end、 center三个值)，
不同的是crossAxisAlignment的参考系是verticalDirection，
即verticalDirection值为VerticalDirection.down时crossAxisAlignment.start指顶部对齐，
verticalDirection值为VerticalDirection.up时，crossAxisAlignment.start指底部对齐；
而crossAxisAlignment.end和crossAxisAlignment.start正好相反；

children ：子组件数组。
*
*constrainedBox或SizedBox（我们将在后面章节中专门介绍着两个Widget）来强制更改宽度限制
*ConstrainedBox(
  constraints: BoxConstraints(minWidth: double.infinity),
  child: Column(
*
*
* */

class RowColumnApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "RowColumnApp",
      home: Column(
        //测试Row对齐方式，排除Column默认居中对齐的干扰
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(//竖直排列
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("hello"),
              Text("1"),
            ],
          ),
          Column(
            //由于mainAxisSize值为MainAxisSize.min，Row的宽度等于两个Text的宽度和，
            // 所以对齐是无意义的，所以会从左往右显示
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("hello"),
              Text("2"),
            ],
          ),
          Row(//水平排列
            mainAxisAlignment: MainAxisAlignment.end,
            textDirection: TextDirection.ltr,//从右向左的顺序排列
            children: <Widget>[
              Text("hello"),
              Text("3"),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,//底对齐。
            children: <Widget>[
              Text("hello"),
              Text("4",style: TextStyle(fontSize: 14.0),),
            ],
          ),
        ],
      )
    );
  }
}
