import 'package:flutter/material.dart';

/*
* 容器的大小可以通过width、height属性来指定，也可以通过constraints来指定；如果它们同时存在时，
* width、height优先。实际上Container内部会根据width、height来生成一个constraints。
color和decoration是互斥的，如果同时设置它们则会报错！实际上，当指定color时，
Container内会自动创建一个decoration。
*/

class ContainerApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("ContainerApp"),),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50.0,left: 120.0), //容器外填充
              constraints: BoxConstraints.tightFor(width: 200.0,height: 150.0),//卡片大小
              decoration: BoxDecoration(//背景装饰
                gradient: RadialGradient(//背景径向渐变
                    colors: [Colors.red, Colors.orange],
                  center: Alignment.topLeft,
                  radius: .98
                ),
                boxShadow: [ //卡片阴影 //卡片阴影
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0
                  )
                ]
              ),
              transform: Matrix4.rotationZ(.2), //卡片倾斜变换
              alignment: Alignment.center,//卡片内文字居中
              child: Text("5.20",style: TextStyle(color: Colors.white,fontSize:40 ),),//卡片文字
            ),
            
            Container(
              margin: EdgeInsets.all(20.0),
              color: Colors.orange,
              child: Text("Hello world!"),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              color: Colors.orange,
              child: Text("Hello world!"),
            ),

            //等价于上面
            Padding(
                padding: EdgeInsets.all(20.0),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text("Hello world!"),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Hello world!"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}