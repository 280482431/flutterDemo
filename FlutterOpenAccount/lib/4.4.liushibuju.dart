import 'package:flutter/material.dart';

class Liushibuju extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "",
//      home: new WrapWidget(),
      home: Flow1(),
    );
  }
}

class WrapWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("流式布局"),
      ),
      body:Wrap(//流式布局
        spacing: 8.0,// 主轴(水平)方向间距
        runSpacing: 4.0,// 纵轴（垂直）方向间距
        alignment: WrapAlignment.center,//沿主轴方向居中
        children: <Widget>[
          new Chip(
            avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text("A")),
            label: new Text("Hamilton"),
          ),
          new Chip(
              avatar: new CircleAvatar(backgroundColor: Colors.blue,child: Text("M"),),
              label: new Text("Lafayette")
          ),
          new Chip(
              avatar: new CircleAvatar(backgroundColor: Colors.blue,child: Text("H"),),
              label: Text("Mulligan")
          ),
          new Chip(
              avatar: new CircleAvatar(backgroundColor: Colors.blue,child: Text("J"),),
              label: Text("Laurens")),
        ],
      ),
    );
  }
}

class Flow1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Flow(
          delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
          children: <Widget>[
            new Container(width: 80.0,height: 80.0,color: Colors.red,),
            new Container(width: 80.0,height: 80.0,color: Colors.redAccent,),
            new Container(width: 80.0,height: 80.0,color: Colors.
              cyan),
            new Container(width: 80.0,height: 80.0,color: Colors.blue,),
            new Container(width: 80.0,height: 80.0,color: Colors.grey,),
            new Container(width: 80.0,height: 80.0,color: Colors.black,),
            new Container(width: 80.0,height: 80.0,color: Colors.white,),
            new Container(width: 80.0,height: 80.0,color: Colors.orange,),
            new Container(width: 80.0,height: 80.0,color: Colors.yellow,),
            new Container(width: 80.0,height: 80.0,color: Colors.amber,),
          ],
      ),
    );
  }
}

class TestFlowDelegate extends FlowDelegate{
  EdgeInsets margin = EdgeInsets.zero;
  TestFlowDelegate({this.margin});
  @override
  void paintChildren(FlowPaintingContext context){
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for(int i = 0;i < context.childCount; i++){
      var w = context.getChildSize(i).width + x + margin.right;
      if(w < context.size.width){
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      }else{
        x = margin.left;
        y += context.getChildSize(i).height+margin.top+margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i,transform: new Matrix4.translationValues(x, y, 0.00));
        x += context.getChildSize(i).width+margin.left+margin.right;
      }
    }
  }

  @override
  getSize(BoxConstraints constraints){
    return Size(double.infinity, 450.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate){
    return oldDelegate != this;
  }
}