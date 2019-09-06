import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

/*
* itemExtent：该参数如果不为null，则会强制children的“长度”为itemExtent的值；
* 这里的“长度”是指滚动方向上子组件的长度，也就是说如果滚动方向是垂直方向，
* 则itemExtent代表子组件的高度；如果滚动方向为水平方向，则itemExtent就代表子组件的宽度。
* 在ListView中，指定itemExtent比让子组件自己决定自身长度会更高效，这是因为指定itemExtent后，
* 滚动系统可以提前知道列表的长度，而无需每次构建子组件时都去再计算一下，
* 尤其是在滚动位置频繁变化时（ 滚动系统需要频繁去计算列表高度）。
*
shrinkWrap：该属性表示是否根据子组件的总长度来设置ListView的长度，默认值为false 。默认情况下，
ListView的会在滚动方向尽可能多的占用空间。当ListView在一个无边界(滚动方向上)的容器中时，
shrinkWrap必须为true。

addAutomaticKeepAlives：该属性表示是否将列表项（子组件）包裹在AutomaticKeepAlive 组件中；
典型地，在一个懒加载列表中，如果将列表项包裹在AutomaticKeepAlive中，
在该列表项滑出视口时它也不会被GC（垃圾回收），它会使用KeepAliveNotification来保存其状态。
如果列表项自己维护其KeepAlive状态，那么此参数必须置为false。
addRepaintBoundaries：该属性表示是否将列表项（子组件）包裹在RepaintBoundary组件中。
当可滚动组件滚动时，将列表项包裹在RepaintBoundary中可以避免列表项重绘，
但是当列表项重绘的开销非常小（如一个颜色块，或者一个较短的文本）时，
不添加RepaintBoundary反而会更高效。和addAutomaticKeepAlive一样，
如果列表项自己维护其KeepAlive状态，那么此参数必须置为false。
* */

class ListViewApp1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: ListViewState(),
    );
  }
}

class ListViewState extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:
//      ListViewState(),
//      ListViewBuilder(),
//      ListViewSeparated(),
//        InfiniteListView(),
        ListTitleS(),
    );
  }
}

class ListState extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        const Text('I\'m dedicating every day to you'),
        const Text('Domestic life was never quite my style'),
        const Text('When you smile, you knock me out, I fall apart'),
        const Text('And I thought I was so smart'),
      ],
    );
  }
}

/*
* ListView.builder适合列表项比较多（或者无限）的情况，因为只有当子组件真正显示的时候才会被创建，
* 也就说通过该构造函数创建的ListView是支持基于Sliver的懒加载模型的*/
class ListViewBuilder extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(itemBuilder: (BuildContext context,int index){//无限刷
      return ListTile(title:  Text("$index"),);
    });
  }
}

/*
* ListView.separated可以在生成的列表项之间添加一个分割组件，
* 它比ListView.builder多了一个separatorBuilder参数，该参数是一个分割组件生成器。
* */
class ListViewSeparated extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget divider1 = Divider(color: Colors.blue,);
    Widget divider2 = Divider(color: Colors.red,);
    return ListView.separated(
        itemBuilder: (BuildContext context, int index){
          return ListTile(title: Text("$index"),);
    }, separatorBuilder: (BuildContext context, int index){
          return index%2==0?divider1:divider2;
    }, itemCount: 100);
  }
}

/*
*无限加载列表
*
* */
class InfiniteListView extends StatefulWidget {
  @override
  _InfiniteListViewState createState() => new _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _words.length,
      itemBuilder: (context, index) {
        //如果到了表尾
        if (_words[index] == loadingTag) {
          //不足100条，继续获取数据
          if (_words.length - 1 < 100) {
            //获取数据
            _retrieveData();
            //加载时显示loading
            return Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(strokeWidth: 2.0)
              ),
            );
          } else {
            //已经加载了100条数据，不再获取数据。
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text("没有更多了", style: TextStyle(color: Colors.grey),)
            );
          }
        }
        //显示单词列表项
        return ListTile(title: Text(_words[index]));
      },
      separatorBuilder: (context, index) => Divider(height: .0),
    );
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(_words.length - 1,
          //每次生成20个单词
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList()
      );
      setState(() {
        //重新构建列表
      });
    });
  }
}

/*
* 添加固定列表头
* */
class ListTitleS extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        ListTile(title: Text(""),),
        //Material设计规范中状态栏、导航栏、ListTile高度分别为24、56、56
        Expanded(//SizedBox: height: MediaQuery.of(context).size.height-24-56-56,
          child:ListView.builder(itemBuilder: (BuildContext context, int index){
            return ListTile(title: Text("$index"),);
          }),
        ),
      ],
    );
  }
}