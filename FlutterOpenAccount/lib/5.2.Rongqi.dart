import 'package:flutter/material.dart';

/*
* 尺寸限制类容器用于限制容器大小，Flutter中提供了多种这样的容器，
* 如ConstrainedBox、SizedBox、UnconstrainedBox、AspectRatio等
* */

class BoxApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
//      home: BoxWidget(),
      home: DecoratedBoxState(),
    );
  }
}

class RedBox extends StatelessWidget{
  final Color color;
  const RedBox({
    Key key,
    this.color
  }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DecoratedBox(decoration: BoxDecoration(color: color));
  }
}

class BoxWidget extends StatelessWidget{
  Widget redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("BoxWidget"),
        actions: <Widget>[
          UnconstrainedBox(//不去掉父类约束，直接加约束，会不成功，取最大的约束
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.cyan),
              ),
            ),
          )
        ],
      ),
      body:Column(
        children: <Widget>[

          ConstrainedBox(//对子组件添加额外的约束
            constraints: BoxConstraints(
                minWidth: double.infinity,
                maxHeight: 50.0
            ),
            child: Container(
              height: 5.0,
              child: RedBox(color:Colors.blue),
            ),
          ),

          // 等价
          SizedBox(
            width: 80,
            height: 80,
            child: RedBox(color:Colors.red),
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 80,height: 80),
            child: RedBox(color:Colors.green),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 80,maxWidth: 80,minHeight: 80,maxHeight: 80),
            child: RedBox(color:Colors.blue),
          ),

          //多重限制
          ConstrainedBox(//,对于minWidth和minHeight来说，是取父子中相应数值较大的;
            constraints: BoxConstraints(minWidth: 60,minHeight: 60),//父
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 90,minHeight: 20),//子
              child: RedBox(color:Colors.yellow),//孙
            ),
          ),
          ConstrainedBox(//maxWidth????(0,0)?
            constraints: BoxConstraints(maxWidth: 90,maxHeight: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 60,maxHeight: 60),
              child: RedBox(color: Colors.blue,),
            ),
          ),

          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 100,minHeight: 100),
            child: UnconstrainedBox(//去除限制
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 50,minHeight: 50),
                child: RedBox(color:Colors.cyan),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

/*
* 5.3DecoratedBox可以在其子组件绘制前(或后)绘制一些装饰（Decoration），如背景、边框、渐变等
* */
class DecoratedBoxState extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("DecoratedBoxState"),),
      body: Column(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.red,Colors.orange[700]]), //背景渐变
                borderRadius: BorderRadius.circular(3.0),//3像素圆角
                boxShadow:[//阴影
                  BoxShadow(
                      color: Colors.orange,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0
                  )
                ]
            ),
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 80.0,vertical: 18.0),
              child: Text("Login",style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}