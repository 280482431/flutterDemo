import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/*
* 1。不能点击：不能用父路由来掉子路由AlertDialog
* 2。点击一，封装一个继承于StatefulWidget的StatefulWidget，重写State，来管理状态
* 3。点击二，封装一个继承于StatefulBuilder的StatefulBuilder，重写State，来管理状态
*  Widget build(BuildContext context) => widget.builder(context, setState);将参数往下传
* 4。使用(context as Element).markNeedsBuild();方法刷新UI
* */

class AlertViewApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("AlertDialog"),),
        body:  CommonAlertDialog(),
//        body: DialogRoute(),
      ),
    );
  }
}

/*
* const AlertDialog({
  Key key,
  this.title, //对话框标题组件
  this.titlePadding, // 标题填充
  this.titleTextStyle, //标题文本样式
  this.content, // 对话框内容组件
  this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0), //内容的填充
  this.contentTextStyle,// 内容文本样式
  this.actions, // 对话框操作按钮组
  this.backgroundColor, // 对话框背景色
  this.elevation,// 对话框的阴影
  this.semanticLabel, //对话框语义化标签(用于读屏软件)
  this.shape, // 对话框外形
})
*/

///自定义 Dialog
class CommonAlertDialog extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // 弹出对话框
    Future<bool>showDeleteConfirmDialog1(){
      return showDialog<bool>(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("提示"),
              content: Text("您确定要删除当前文件吗?"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),//关闭对话框
                  child: Text("取消"),
                ),
                FlatButton(
                  // ... 执行删除操作
                  onPressed: () => Navigator.of(context).pop(true), //关闭对话框
                  child: Text("删除"),
                ),
              ],
            );
          }
      );
    }

    Future<int> changeLanguage() async{
      int i = await showDialog<int>(
          context: context,
        builder: (BuildContext context){
            return SimpleDialog(
              title: const Text("请选择语言"),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: (){
                    // 返回
                    Navigator.pop(context,1);
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                    child: const Text("中文简体"),
                  ),
                ),
                SimpleDialogOption(
                  onPressed: (){
                    // 返回2
                    Navigator.pop(context,2);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: const Text("美国英语"),
                  ),
                ),
              ],
            );
        }
      );
      if(i != null){
        print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
      }
    }

    Future<int> showListDialog() async {
      int index = await showDialog<int>(
          context: context,
          builder: (BuildContext context){
            var child = Column(
              children: <Widget>[
                ListTile(title: Text("请选择"),),
                Expanded(
                    child: ListView.builder(
                        itemCount: 30,
                        itemBuilder: (BuildContext context,int index){
                          return ListTile(
                            title: Text("$index"),
                            onTap: () => Navigator.of(context).pop(index),
                          );
                        }
                    )),
              ],
            );
            //使用AlertDialog会报错
            //return AlertDialog(content: child);
            return Dialog(child: child,);
          }
      );
      if (index != null){
        print("点击了：$index");
      }
    }

    Future<void> showBoxList() async{
      int index = await showDialog<int>(
          context: context,
          builder: (BuildContext context){
            var child = Column(
              children: <Widget>[
                ListTile(title: Text("请选择"),),
                Expanded(
                    child: ListView.builder(
                        itemCount: 30,
                        itemBuilder: (BuildContext context,int index){
                          return ListTile(
                            title: Text("$index"),
                            onTap: () => Navigator.of(context).pop(index),
                          );
                        }
                    )),
              ],
            );
            //使用AlertDialog会报错
            //return AlertDialog(content: child);
            return UnconstrainedBox(
              constrainedAxis: Axis.vertical,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 280),
                child: Material(
                  child: child,
                  type: MaterialType.card,
                ),
              ),
            );
          }
      );
      if (index != null){
        print("点击了：$index");
      }
    }

    /*
*Future<T> showGeneralDialog<T>({
  @required BuildContext context,
  @required RoutePageBuilder pageBuilder, //构建对话框内部UI
  bool barrierDismissible, //点击遮罩是否关闭对话框
  String barrierLabel, // 语义化标签(用于读屏软件)
  Color barrierColor, // 遮罩颜色
  Duration transitionDuration, // 对话框打开/关闭的动画时长
  RouteTransitionsBuilder transitionBuilder, // 对话框打开/关闭的动画
})
* */

///自定义遮罩层 对话框
    Widget _buildMaterialDialogTransitions(
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
      // 使用缩放动画
      return ScaleTransition(
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ),
        child: child,
      );
    }

    Future<T> showCustomDialog<T>({
      @required BuildContext context,
      bool barrierDismissible = true,
      WidgetBuilder builder,
    }){
      final ThemeData theme = Theme.of(context,shadowThemeOnly: true);
      return showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext buildContext, Animation<double>animation,
            Animation<double>secondaryAnimation){
          final Widget pageChild = Builder(builder: builder);
          return SafeArea(
              child: Builder(builder: (BuildContext context){
                return theme != null?Theme(data: theme, child: pageChild):pageChild;
              }),
          );
        },
        barrierDismissible: barrierDismissible,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.blue,// 自定义遮罩颜色
        transitionDuration: const Duration(milliseconds: 150),
        transitionBuilder: _buildMaterialDialogTransitions,
      );
    }

    Future<void> showCustomerDialog() async{
      bool result = await showCustomDialog<bool>(
        context:context,
        builder:(context){
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定要删除当前文件吗?"),
            actions: <Widget>[
              FlatButton(
                  onPressed: ()=>Navigator.of(context).pop(),
                  child: Text("取消")
              ),
              FlatButton(
                  onPressed: ()=>Navigator.of(context).pop(true),
                  child: Text("删除")
              ),
            ],
          );
        }
      );
    }
/*
* 实现很简单，直接调用Navigator的push方法打开了一个新的对话框路由_DialogRoute，
* 然后返回了push的返回值。可见对话框实际上正是通过路由的形式实现的，
* 这也是为什么我们可以使用Navigator的pop 方法来退出对话框的原因。
* 关于对话框的样式定制在_DialogRoute中，没有什么新的东西，读者可以自行查看。
* */


/// 1。能点击选择的对话框  单独抽离出StatefulWidget
    ///
    Future<bool> showDeleteConfirmDialog3(){
      bool _withTree = false;//记录复选框是否选中
      return showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("您确定要删除当前文件吗?"),
                Row(
                  children: <Widget>[
                    Text("同时删除子目录？"),
                    DialogCheckbox(
                      value: _withTree, //默认不选中
                      onChange: (bool value) {
                        //更新选中状态
                        _withTree = !_withTree;
                      },
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("取消"),
              ),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(_withTree),
                  child: Text("删除")
              ),
            ],
          );
        }
      );
    }

    //3.精妙的解法
    /*
* 要确认这个问题，我们就得先想想UI是怎么更新的，我们知道在调用setState方法后
* StatefulWidget就会重新build，那setState方法做了什么呢？我们能不能从中找到方法？
* 顺着这个思路，我们就得看一下setState的核心源码：
* */

/*
* 可以发现，setState中调用了Element的markNeedsBuild()方法，我们前面说过，Flutter是一个响应式框架，
* 要更新UI只需改变状态后通知框架页面需要重构即可，而Element的markNeedsBuild()方法正是来实现这个功能的！
* markNeedsBuild()方法会将当前的Element对象标记为“dirty”（脏的），在每一个Frame，
* Flutter都会重新构建被标记为“dirty”Element对象。既然如此，我们有没有办法获取到对话框内部UI的Element对象，
* 然后将其标示为为“dirty”呢？答案是肯定的！我们可以通过Context来得到Element对象，
* 至于Element与Context的关系我们将会在后面“Flutter核心原理”一章中再深入介绍，现在只需要简单的认为：
* 在组件树中，context实际上就是Element对象的引用。知道这个后，那么解决的方案就呼之欲出了，
* 我们可以通过如下方式来让复选框可以更新：
* */
    Future<bool>showDeleteConfirmDialog4(){
      bool _withTree = false;
      return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("您确定要删除当前文件吗?"),
                Row(
                  children: <Widget>[
                    Text("同时删除子目录？"),
                    // 通过Builder来获得构建Checkbox的`context`，
                    // 这是一种常用的缩小`context`范围的方式
                    Builder(
                        builder: (BuildContext contet){
                      return Checkbox(
                          value: _withTree,
                          onChanged: (bool value){
                            (context as Element).markNeedsBuild();
                            _withTree = !_withTree;
                          }
                      );
                    }),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () =>Navigator.of(context).pop(),
                  child: Text("取消")
              ),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(_withTree),
                  child: Text("删除")
              ),
            ],
          );
        }
      );
    }

    /*******************************OtherAlertView*************************************/
//1。底部菜单列表
    // 弹出底部菜单列表模态对话框
    Future<int>_showModalBottomSheet(){
      return showModalBottomSheet(
          context: context, 
          builder: (BuildContext context){
            return ListView.builder(
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  title: Text("$index"),
                  onTap: () => Navigator.of(context).pop(index),
                );
              },
              itemCount: 30,
            );
          });
    }

    PersistentBottomSheetController<int> _showBottomSheet(){
      return showBottomSheet<int>(
          context: context,
          builder: (BuildContext context){
            return ListView.builder(
              itemCount: 30,
                itemBuilder: (BuildContext context,int index){
                  return ListTile(
                    title: Text("$index"),
                    onTap: (){
                      print("$index");
                      Navigator.of(context).pop(index);
                    },
              );
            });
          });
    }

    //2。Loading框

    //自定义宽度
    showLoadingDialog() {
      showDialog(
        context: context,
        barrierDismissible: false, //点击遮罩不关闭对话框
        builder: (context) {
          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: SizedBox(
              width: 280,
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(value: 8,),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text("正在加载，请稍后..."),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    //不能改变宽度
    showLoadingDialog1(){
      showDialog(context: context,
        barrierDismissible: false,
        builder: (context){
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text("正在加载，请稍后..."),
              ),
            ],
          ),
        );
        }
      );
    }

//3.日历选择
    Future<DateTime>_showDatePicker1(){
      var date = DateTime.now();
      return showDatePicker(
          context: context,
          initialDate: date,
          firstDate: date,
          lastDate: date.add(Duration(days: 30),
          ),
      );
    }

    _showDatePicker2(){
      var date = DateTime.now();
      return showCupertinoModalPopup(
        context: context,
        builder: (ctx){
          return SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,//日期时间模式，
                maximumDate: date.add(
                  Duration(days: 30),
                ),
                minimumDate: date,//最小日期时间，
                maximumYear: date.year+1,//最大日期时间，
                initialDateTime: DateTime.now(),//选中日前
                use24hFormat: false, // 是否使用24小时格式
                onDateTimeChanged: (DateTime value){//日期改变时调用的方法
                  print(value);
            }),
          );
        }
      );
    }

    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("对话框1"),
              onPressed: () async{
                //弹出对话框并等待其关闭
            bool delete = await showDeleteConfirmDialog1();
            if(delete == null){
              print("取消删除");
            }else{
              print("已确认删除");
            }
          }),
          RaisedButton(
            child: Text("选择语言"),
              onPressed: () async{
              int index = await changeLanguage();
              if(index ==1){
                print("Chinese");
              }else{
                print("English");
              }
          }),
          RaisedButton(
            child: Text("list"),
              onPressed: () async{
                int index = await showListDialog();
                print(index);
          }),
          RaisedButton(
            child: Text("Box"),
            onPressed: () async{
              await showBoxList();
            },
          ),
          RaisedButton(
              child: Text("Customer"),
              onPressed: ()async{
            await showCustomerDialog();
          }),
          RaisedButton(
            child: Text("单独抽离出StatefulWidget"),
              onPressed: ()async{
                bool deleteTree = await showDeleteConfirmDialog3();
                if(deleteTree == null){
                  print("取消删除");
                }else{
                  print("同时删除子目录: $deleteTree");
                }
          }),
          /*******************************OtherAlertView*************************************/
          RaisedButton(
            child: Text("显示底部菜单列表"),
              onPressed: ()async{
                int type = await _showModalBottomSheet();
                print(type);
          }),
          RaisedButton(
            child: Text("PersistentBottomSheetController"),
              onPressed:()async{
              _showBottomSheet();
              }),

          RaisedButton(
            child: Text("showLoadingDialog"),
            onPressed: () => showLoadingDialog(),
          ),
          RaisedButton(
            child: Text("showLoadingDialog1"),
              onPressed: () => showLoadingDialog1()
          ),


          RaisedButton(
            child: Text("web Date"),
            onPressed: () => showDatePicker(
              context: context,
              initialDate: DateTime.parse("20190927"),//初始选中日期
              firstDate: DateTime.parse("20190101"),//可选日期范围第一个日期
              lastDate: DateTime.parse("20201212"),//可选日期范围最后一个日期
              selectableDayPredicate: (dateTime){ //通过此方法可以过滤掉可选范围内不可选的特定日期
                if(dateTime.day == 10 || dateTime.day == 20){
                  return false;
                }
                return true;
              },
              initialDatePickerMode: DatePickerMode.day,
            ).then((dateTime){ //初始化选择模式，有day和year两种
              print("当前选择了：${dateTime.year}年${dateTime.month}月${dateTime.day}日");
            }),
          ),
          RaisedButton(
            child: Text("Web time"),
            onPressed: () => showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
          ).then((timeOfDay){
            if(timeOfDay == null){
              return;
            }
          }),
          ),
          
          RaisedButton(
            child: Text("_showDatePicker2"),
              onPressed: ()=> _showDatePicker2()
          ),
          
        ],
      ),
    );
  }
}

/// 不能点击的对话框

class DialogRoute extends StatefulWidget{
  @override
  _DialogRouteState createState() => _DialogRouteState();
}

class _DialogRouteState extends State<DialogRoute>{
  bool withTree = false;
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text("不能选择的对话框2"),
            onPressed: () async{
                bool delete = await showDeleteConfirmDialog2();
                if(delete == null){
                  print("取消删除");
                }else{
                  print("同时删除子目录: $delete");
                }
        }),
      ],
    );
  }

  Future<bool>showDeleteConfirmDialog2(){
    withTree = false;
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("不能选择的对话框?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录"),
//                  Checkbox(
//                      value: withTree,
//                      onChanged: (bool value){
//                        setState(() {
//                          withTree = !withTree;
//                        });
//                  }),
                //2.可以点击的对话框  重写StatefulBuilder
                  StatefulBuilder(
                      builder: (context, _setState){
                    return Checkbox(
                        value: withTree,
                        onChanged: (bool value){
                          _setState((){
                            withTree = ! withTree;
                          });
                        });
                  }),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(), 
                child: Text("取消")),
            FlatButton(
                onPressed: () => Navigator.of(context).pop(withTree),
                child: Text("删除")),
          ],
        );
      }
    );
  }
}

/*
* 然后，当我们运行上面的代码时我们会发现复选框根本选不中！为什么会这样呢？其实原因很简单，
* 我们知道setState方法只会针对当前context的子树重新build，但是我们的对话框并不是
* 在_DialogRouteState的build 方法中构建的，而是通过showDialog单独构建的，
* 所以调用在_DialogRouteState的context中调用setState是无法影响通过showDialog构建的UI的。
* 另外，我们可以从另外一个角度来理解这个现象，前面说过对话框也是通过路由的方式来实现的，
* 那么上面的代码实际上就等同于企图在父路由中调用setState来让子路由更新，这显然是不行的！
* 简尔言之，根本原因就是context不对。那如何让复选框可点击呢？通常有如下三种方法：
* */

///1.可以点击的对话框，  单独抽离出StatefulWidget
// 单独封装一个内部管理选中状态的复选框组件
class DialogCheckbox extends StatefulWidget{
  DialogCheckbox({
    Key key,
    this.value,
    @required this.onChange,
  });

  final ValueChanged<bool> onChange;
  final bool value;

  @override
  _DialogCheckboxState createState() => _DialogCheckboxState();
}

class _DialogCheckboxState extends State<DialogCheckbox>{
  bool value;

  @override
  void initState() {
    // TODO: implement initState
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Checkbox(
        value: value,
        onChanged: (v){
          widget.onChange(v);
          setState(() {
            value = v;
          });
        });
  }
}

///2。可以点击的对话框
/*
*使用StatefulBuilder方法

上面的方法虽然能解决对话框状态更新的问题，但是有一个明显的缺点——对话框上所有需要会改变状态的
组件都得单独封装在一个在内部管理状态StatefulWidget中，这样不仅麻烦，而且复用性不大。
因此，我们来想想能不能找到一种更简单的方法？上面的方法本质上就是将对话框的状态置于
一个StatefulWidget的上下文中，由StatefulWidget在内部管理，那么我们有没有办法在不需要
单独抽离组件的情况下创建一个StatefulWidget的上下文呢？想到这里，我们可以从Builder组件的
实现获得灵感。在前面介绍过Builder组件可以获得组件所在位置的真正的Context，那它是怎么实现的呢
，我们看看它的源码：
* */

/*
* 可以看到，Builder实际上只是继承了StatelessWidget，然后在build方法中对获取当前context后
* 将构建方法代理到了builder回调，Builder实际上是获取了StatelessWidget 的上下文。
* 那我们能否用相同的方法获取StatefulWidget 上下文，并代理其build方法呢？我们照猫画虎，
* 来封装一个StatefulBuilder方法：
* */

class StatefulBuilder extends StatefulWidget {
  const StatefulBuilder({
    Key key,
    @required this.builder,
  }) : assert(builder != null),
        super(key: key);

  final StatefulWidgetBuilder builder;

  @override
  _StatefulBuilderState createState() => _StatefulBuilderState();
}

class _StatefulBuilderState extends State<StatefulBuilder>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.builder(context,setState);
  }
}

///3.精妙的解法


