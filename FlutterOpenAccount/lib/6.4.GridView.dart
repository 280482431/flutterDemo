import 'package:flutter/material.dart';
/*flutter_staggered_grid_view 0.3.0*/
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/*
* crossAxisCount：横轴子元素的数量。此属性值确定后子元素在横轴的长度就确定了，
* 即ViewPort横轴长度除以crossAxisCount的商。
*
mainAxisSpacing：主轴方向的间距。

crossAxisSpacing：横轴方向子元素的间距。

childAspectRatio：子元素在横轴长度和主轴长度的比例。由于crossAxisCount指定后，
子元素横轴长度就确定了，然后通过此参数值就可以确定子元素在主轴的长度。
* */

class GridViewApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
//      home: GridViewNormal(),
//      home: GridViewNormal(),
//      home: GridDelegate(),
//      home: GridViewExtent(),
      home: InfiniteGridView(),
    );
  }
}

//横轴固定数量子元素的GridView
class GridViewNormal extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,//横轴三个子widget
              childAspectRatio: 1.0//宽高比为1时，子widget
          ),
          children: <Widget>[
            Icon(Icons.ac_unit),
            Icon(Icons.airport_shuttle),
            Icon(Icons.all_inclusive),
            Icon(Icons.beach_access),
            Icon(Icons.cake),
            Icon(Icons.free_breakfast),
          ],
      ),
    );
  }
}

//等价于：
class GridViewCount extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            children: <Widget>[
              Icon(Icons.ac_unit),
              Icon(Icons.airport_shuttle),
              Icon(Icons.all_inclusive),
              Icon(Icons.beach_access),
              Icon(Icons.cake),
              Icon(Icons.free_breakfast),
            ],
          ),
        ],
      ),
    );
  }
}

//固定最大长度的的GridView
class GridDelegate extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: GridView(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 120.0,childAspectRatio: 2.0),
        children: <Widget>[
          Icon(Icons.ac_unit),
          Icon(Icons.airport_shuttle),
          Icon(Icons.all_inclusive),
          Icon(Icons.beach_access),
          Icon(Icons.cake),
          Icon(Icons.free_breakfast),
        ],
      ),
    );
  }
}

//等价于
class GridViewExtent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: GridView.extent(maxCrossAxisExtent: 120.0,childAspectRatio: 2.0,
        children: <Widget>[
          Icon(Icons.ac_unit),
          Icon(Icons.airport_shuttle),
          Icon(Icons.all_inclusive),
          Icon(Icons.beach_access),
          Icon(Icons.cake),
          Icon(Icons.free_breakfast),
      ],),
    );
  }
}

class InfiniteGridView extends StatefulWidget{
  @override
  _InfiniteGridViewState createState() => new _InfiniteGridViewState();
}

class _InfiniteGridViewState extends State<InfiniteGridView>{
  List<IconData> _icons = [];//保存Icon数据

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retieveIcons();// 初始化数据
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:       GridView.builder(
        //每行三列//显示区域宽高相等
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 1.0),
          itemBuilder: (context, index){
            //如果显示到最后一个并且Icon总数小于200时继续获取数据
            if(index == _icons.length-1 && _icons.length<200){
              _retieveIcons();
            }
            return Icon(_icons[index]);
          }),
    );
  }

  //模拟异步获取数据
  void _retieveIcons(){
    Future.delayed(Duration(milliseconds: 200)).then((e){
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }

}
