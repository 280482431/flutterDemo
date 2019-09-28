import 'package:flutter/material.dart';

class ColorAndThemeApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
//      home: NavBar();
      home: ThemeColorWdg(),
    );
  }
}

class NaBarWdg extends StatelessWidget{
  //          Color(0xffdc380d); //如果颜色固定可以直接使用整数值
//颜色是一个字符串变量
  var c = "dc380d";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Column(
      children: <Widget>[
        //通过方法将Alpha设置为FF,
        NavBar(color: Color(int.parse(c,radix:16)|0xFF000000),  title: "标题",),
        //通过方法将Alpha设置为FF
        NavBar(color: Color(int.parse(c,radix:16)).withAlpha(255),title: "标题",),
      ],
    ),);
  }
}

/*
* Bit（位）	颜色
0-7	        蓝色
8-15	      绿色
16-23	      红色
24-31	      Alpha (不透明度)
*/

class NavBar extends StatelessWidget{
  final String title;
  final Color color;
  NavBar({
    Key key,
    this.color,
    this.title,
});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      constraints: BoxConstraints(
        minHeight: 52,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color.computeLuminance() < 0.5?Colors.white:Colors.black,
        ),
      ),
      alignment: Alignment.center,
    );
  }
}

/*
*ThemeData({
  Brightness brightness, //深色还是浅色
  MaterialColor primarySwatch, //主题颜色样本，见下面介绍
  Color primaryColor, //主色，决定导航栏颜色
  Color accentColor, //次级色，决定大多数Widget的颜色，如进度条、开关等。
  Color cardColor, //卡片颜色
  Color dividerColor, //分割线颜色
  ButtonThemeData buttonTheme, //按钮主题
  Color cursorColor, //输入框光标颜色
  Color dialogBackgroundColor,//对话框背景颜色
  String fontFamily, //文字字体
  TextTheme textTheme,// 字体主题，包括标题、body等文字样式
  IconThemeData iconTheme, // Icon的默认样式
  TargetPlatform platform, //指定平台，应用特定平台控件风格
  ...
})
* */

class ThemeColorWdg extends StatefulWidget{
  @override
  _ThemeColorWdg createState() => _ThemeColorWdg();
}

class _ThemeColorWdg extends State<ThemeColorWdg>{
  Color _themeColor = Colors.teal;//当前路由主题色

  @override
  Widget build(BuildContext context) {
    // TODO: implement( build
    ThemeData themeData = Theme.of(context);

    return Theme(
      data: ThemeData(
        primarySwatch: _themeColor,//用于导航栏、FloatingActionButton的背景色等
        iconTheme: IconThemeData(color: _themeColor) //用于Icon颜色
      ),
      child: Scaffold(
        appBar: AppBar(title: Text("主题测试"),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.favorite),
              Icon(Icons.airport_shuttle),
              Text("颜色跟随主题")
            ],
          ),
            //为第二行Icon自定义颜色（固定为黑色)
            Theme(
                data: themeData.copyWith(
                  primaryColor: Colors.black
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite),
                    Icon(Icons.airport_shuttle),
                    Text(" 颜色固定黑色"),
                  ],
                ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: ()=>
              setState(() =>
                _themeColor =
                    _themeColor == Colors.teal?Colors.blue:Colors.teal
              ),
        child: Icon(Icons.palette),
      ),
      ),
    );
  }
}

/*
*需要注意的有三点：

可以通过局部主题覆盖全局主题，正如代码中通过Theme为第二行图标指定固定颜色（黑色）一样，
这是一种常用的技巧，Flutter中会经常使用这种方法来自定义子树主题。那么为什么局部主题可以覆盖全局主题？
这主要是因为Widget中使用主题样式时是通过Theme.of(BuildContext context)来获取的，我们看看其简化后的代码：

static ThemeData of(BuildContext context, { bool shadowThemeOnly = false }) {
   // 简化代码，并非源码
   return context.inheritFromWidgetOfExactType(_InheritedTheme)
}
context.inheritFromWidgetOfExactType 会在widget树中从当前位置向上查找第一个类型为_InheritedTheme的Widget。
所以当局部使用Theme后，其子树中Theme.of()找到的第一个_InheritedTheme便是该Theme的。

本示例是对单个路由换肤，如果相对整个应用换肤，可以去修改MaterialApp的theme属性。
*
* */