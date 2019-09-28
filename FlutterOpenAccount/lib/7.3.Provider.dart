import 'package:flutter/material.dart';
import 'dart:collection';

//7.3 跨组件状态共享（Provider）

/*
* 在Flutter开发中，状态管理是一个永恒的话题。一般的原则是：如果状态是组件私有的，
* 则应该由组件自己管理；如果状态要跨组件共享，则该状态应该由各个组件共同的父元素来管理。
* 对于组件私有的状态管理很好理解，但对于跨组件共享的状态，管理的方式就比较多了，
* 如使用全局事件总线EventBus（将在下一章中介绍），它是一个观察者模式的实现，
* 通过它就可以实现跨组件状态同步：状态持有方（发布者）负责更新、发布状态，
* 状态使用方（观察者）监听状态改变事件来执行一些操作。下面我们看一个登陆状态同步的简单示
* */

/*通知
*缺点：
1。必须显式定义各种事件，不好管理
2。订阅者必须需显式注册状态改变回调，也必须在组件销毁时手动去解绑回调以避免内存泄露。
* 定义事件：
*enum Event{
  login,
  ... //省略其它事件
}
*
* 发送通知：
*bus.emit(Event.login);
*
*订阅通知
*bus.on(Event.login,onLogin);
*
*取消订阅
* bus.off(Event.login,onLogin);
*
*/

class ProviderApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: ProviderRoute(),
    );
  }
}

/*
* 首先，我们需要一个保存需要共享的数据InheritedWidget，由于具体业务数据类型不可预期，
* 为了通用性，我们使用泛型，定义一个通用的InheritedProvider类，它继承自InheritedWidget：
* */

// 一个通用的InheritedWidget，保存任需要跨组件共享的状态
class InheritedProvider <T> extends InheritedWidget{
  InheritedProvider({@required this.data,Widget child}):super(child:child);

  //共享状态使用泛型
  final T data;

  @override
  bool updateShouldNotify(InheritedProvider<T> oldWidget) {
    // TODO: implement updateShouldNotify
    //在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    return true;
  }
}

/*
* 数据保存的地方有了，那么接下来我们需要做的就是在数据发生变化的时候来重新构建InheritedProvider，
* 那么现在就面临两个问题：

数据发生变化怎么通知？
谁来重新构建InheritedProvider？
第一个问题其实很好解决，我们当然可以使用之前介绍的eventBus来进行事件通知，
但是为了更贴近Flutter开发，我们使用Flutter中SDK中提供的ChangeNotifier类 ，
它继承自Listenable，也实现了一个Flutter风格的发布者-订阅者模式，ChangeNotifier定义大致如下：
*/

// 该方法用于在Dart中获取模板类型
Type _typeOf<T>() => T;

class ChangeNotifierProvider <T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({
    Key key,
    this.data,
    this.child,
  });

  final Widget child;
  final T data;

  //定义一个便捷方法，方便子树中的widget获取共享数据
//  static T of<T>(BuildContext context) {
//    final type = _typeOf<InheritedProvider<T>>();
//    final provider =  context.inheritFromWidgetOfExactType(type) as InheritedProvider<T>;
//    return provider.data;
//  }

  //添加一个listen参数，表示是否建立依赖关系
  static T of<T>(BuildContext context, {bool listen = true}) {
    final type = _typeOf<InheritedProvider<T>>();
    final provider = listen
        ? context.inheritFromWidgetOfExactType(type) as InheritedProvider<T>
        : context.ancestorInheritedElementForWidgetOfExactType(type)?.widget
    as InheritedProvider<T>;
    return provider.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>>{
  void update(){
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() {

    });
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    // TODO: implement didUpdateWidget
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if(widget.data != oldWidget.data){
      oldWidget.data.removeListener(update);
      widget.data.removeListener(update);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // TODO: implement initState
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }

}

class Item{
  Item(this.price, this.count);
  double price;
  int count;
}

class CartModel extends ChangeNotifier{
  // 用于保存购物车中商品列表
  final List<Item> _items = [];

// 禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

// 购物车中商品的总价
  double get totalPrice =>
      _items.fold(0, (value,item) => value + item.count*item.price);

// 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void add(Item item){
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}

class ProviderRoute extends StatefulWidget{
  @override
  _ProviderRouteState createState() => _ProviderRouteState();
}

class _ProviderRouteState extends State<ProviderRoute>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: ChangeNotifierProvider<CartModel>(
        data:CartModel(),
        child: Builder(builder: (context){
          return Column(
            children: <Widget>[
//              Builder(builder: (context){
//                var cart = ChangeNotifierProvider.of<CartModel>(context);
//                print("总价:${cart.totalPrice}");
//                return Text("总价:${cart.totalPrice}");
//              }),
            //优化（1）
              Consumer<CartModel>(
                builder: (context, cart)=> Text("总价: ${cart.totalPrice}")
              ),
              Builder(builder: (context){
                print("RaisedButton build");
                return RaisedButton(
                    child: Text("添加商品"),
                    onPressed: (){
                      //给购物车中添加商品，添加后总价会更新
                        ChangeNotifierProvider.of<CartModel>(context).add(Item(20.0, 1));
                        print("onPressed");
                      },
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}

/*
* Model变化后会自动通知ChangeNotifierProvider（订阅者），
* ChangeNotifierProvider内部会重新构建InheritedWidget，
* 而依赖该InheritedWidget的子孙Widget就会更新。

我们可以发现使用Provider，将会带来如下收益：

我们的业务代码更关注数据了，只要更新Model，则UI会自动更新，
而不用在状态改变后再去手动调用setState()来显式更新页面。
数据改变的消息传递被屏蔽了，我们无需手动去处理状态改变事件的发布和订阅了，
这一切都被封装在Provider中了。这真的很棒，帮我们省掉了大量的工作！
在大型复杂应用中，尤其是需要全局共享的状态非常多时，使用Provider将会大大简化我们的代码逻辑，
降低出错的概率，提高开发效率。
*/

/*
*优化
*
* 我们上面实现的ChangeNotifierProvider是有两个明显缺点：代码组织为题和性能问题
*
* 1.代码组织问题
* Builder(builder: (context){
  var cart=ChangeNotifierProvider.of<CartModel>(context);
  return Text("总价: ${cart.totalPrice}");
})
*这段代码有两点可以优化：

需要显式调用ChangeNotifierProvider.of，当APP内部依赖CartModel很多时，这样的代码将很冗余。
语义不明确；由于ChangeNotifierProvider是订阅者，那么依赖CartModel的Widget自然就是订阅者，
其实也就是状态的消费者，如果我们用Builder 来构建，语义就不是很明确；
如果我们能使用一个具有明确语义的Widget，比如就叫Consumer，这样最终的代码语义将会很明确，
只要看到Consumer，我们就知道它是依赖某个跨组件或全局的状态。
为了优化这两个问题，我们可以封装一个Consumer Widget，实现如下：
*
* */

// 这是一个便捷类，会获得当前context和指定数据类型的Provider
class Consumer<T> extends StatelessWidget{
  Consumer({
    Key key,
    @required this.builder,
    this.child,
  }):assert(builder != null),
        super(key: key);

  final Widget child;

  final Widget Function(BuildContext context, T value)builder;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return builder(
      context,ChangeNotifierProvider.of(context),//自动获取Model
    );
  }

}
/*
Consumer<CartModel>(
builder: (context, cart)=> Text("总价: ${cart.totalPrice}");
)*/

/*
* 2.性能问题

上面的代码还有一个性能问题，就在构建”添加按钮“的代码处：

Builder(builder: (context) {
  print("RaisedButton build"); // 构建时输出日志
  return RaisedButton(
    child: Text("添加商品"),
    onPressed: () {
      ChangeNotifierProvider.of<CartModel>(context).add(Item(20.0, 1));
    },
  );
}
我们点击”添加商品“按钮后，由于购物车商品总价会变化，所以显示总价的Text更新是符合预期的，
但是”添加商品“按钮本身没有变化，是不应该被重新build的。但是我们运行示例，每次点击”添加商品“按钮，
控制台都会输出"RaisedButton build"日志，也就是说”添加商品“按钮在每次点击时其自身都会重新build！
这是为什么呢？如果你已经理解了InheritedWidget的更新机制，那么答案一眼就能看出：
这是因为构建RaisedButton的Builder中调用了ChangeNotifierProvider.of，
也就是说依赖了Widget树上面的InheritedWidget（即InheritedProvider ）Widget，
所以当添加完商品后，CartModel发生变化，会通知ChangeNotifierProvider,
 而ChangeNotifierProvider则会重新构建子树，所以InheritedProvider将会更新，
 此时依赖它的子孙Widget就会被重新构建。

问题的原因搞清楚了，那么我们如何避免这不必要重构呢？既然按钮重新被build是因为按钮和
InheritedWidget建立了依赖关系，那么我们只要打破或解除这种依赖关系就可以了。
那么如何解除按钮和InheritedWidget的依赖关系呢？我们上一节介绍InheritedWidget时已经讲过了：
调用inheritFromWidgetOfExactType() 和 ancestorInheritedElementForWidgetOfExactType()
的区别就是前者会注册依赖关系，而后者不会。所以我们只需要将ChangeNotifierProvider.of的实现改为下面这样既可：
*
* */



/*
*其它状态管理包

现在Flutter社区已经有很多专门用于状态管理的包了，在此我们列出几个相对评分比较高的：

包名	介绍
Provider & Scoped Model	这两个包都是基于InheritedWidget的，原理相似
Redux	是Web开发中React生态链中Redux包的Flutter实现
MobX	是Web开发中React生态链中MobX包的Flutter实现
BLoC	是BLoC模式的Flutter实现
在此笔者不对这些包做推荐，读者有兴趣都可以研究一下，了解它们各自的思想。

总结

本节通过介绍事件总线在跨组件共享中的一些缺点引出了通过InheritedWidget来实现状态的共享的思想，
然后基于该思想实现了一个简单的Provider，在实现的过程中也更深入的探索了InheritedWidget与
其依赖项的注册机制和更新机制。通过本节的学习，读者应该达到两个目标，首先是对InheritedWidget彻底吃透，
其次是Provider的设计思想。

InheritedWidget是Flutter中非常重要的一个Widget，像国际化、主题等都是通过它来实现，
所以我们也不惜篇幅，通过好几节来介绍它的，在下一节中，我们将介绍另一个基于InheritedWidget的
组件Theme(主题)。
*
*
* */