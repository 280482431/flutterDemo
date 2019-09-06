// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**
 * 由(Route)在移动开发中通常指页面（Page），这跟web开发中单页应用的Route概念意义是相同的，Route在Android中通常指一个Activity，在iOS中指一个ViewController。
 * 所谓路由管理，就是管理页面之间如何跳转，通常也可被称为导航管理。这和原生开发类似，无论是Android还是iOS，导航管理都会维护一个路由栈，路由入栈(push)操作对应打开一个新页面，
 * 路由出栈(pop)操作对应页面关闭操作，而路由管理主要是指如何来管理路由栈。***/

//void main() {
//  runApp(FlutterView());
//}

/****MyApp类代表Flutter应用，它继承了 StatelessWidget类，这也就意味着应用本身也是一个widget。
 *在Flutter中，大多数东西都是widget，包括对齐(alignment)、填充(padding)和布局(layout)。
 *Flutter在构建页面时，会调用组件的build方法，widget的主要工作是提供一个build()方法来描述如何构建UI界面（通常是通过组合、拼装其它基础widget）。
 *MaterialApp 是Material库中提供的Flutter APP框架，通过它可以设置应用的名称、主题、语言、首页及路由列表等。MaterialApp也是一个widget。
 *Scaffold 是Material库中提供的页面脚手架，它包含导航栏和Body以及FloatingActionButton（如果需要的话）。 本书后面示例中，路由默认都是通过Scaffold创建。
 *home 为Flutter应用的首页，它也是一个widget。****/

class FlutterView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //应用名称
      title: 'Flutter View',
      theme: ThemeData(
        //主题
        primarySwatch: Colors.grey,
      ),
      //应用首页路由 ctl
      home: MyHomePage(),
    );
  }
}

/**MyHomePage 是应用的首页，它继承自StatefulWidget类，表示它是一个有状态的widget（Stateful widget）。
 *现在，我们可以简单认为Stateful widget 和Stateless widget有两点不同：
 *Stateful widget可以拥有状态，这些状态在widget生命周期中是可以变的，而Stateless widget是不可变的。
 *Stateful widget至少由两个类组成：
 *一个StatefulWidget类。
 *一个 State类； StatefulWidget类本身是不变的，但是 State类中持有的状态在widget生命周期中可能会发生变化。
 *_MyHomePageState类是MyHomePage类对应的状态类。看到这里，细心的读者可能已经发现，和MyApp 类不同， MyHomePage类中并没有build方法，
 *取而代之的是，build方法被挪到了_MyHomePageState方法中，至于为什么这么做，先留个疑问，在分析完完整代码后再来解答。**/

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String _channel = 'increment';
  static const String _pong = 'pong';
  static const String _emptyMessage = '';
  static const BasicMessageChannel<String> platform =
      BasicMessageChannel<String>(_channel, StringCodec());

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    platform.setMessageHandler(_handlePlatformIncrement);
  }

  /***当按钮点击时，会调用此函数，该函数的作用是先自增_counter，然后调用setState 方法。
   *setState方法的作用是通知Flutter框架，有状态发生了改变，Flutter框架收到通知后，会执行build方法来根据新的状态重新构建界面，
   *Flutter 对此方法做了优化，使重新执行变的很快，所以你可以重新构建任何需要更新的东西，而无需分别去修改各个widget。**/
  Future<String> _handlePlatformIncrement(String message) async {
    setState(() {
      _counter++;
    });
    return _emptyMessage;
  }

  void _sendFlutterIncrement() {
    platform.send(_pong);
  }
/**构建UI界面
 *构建UI界面的逻辑在build方法中，当MyHomePage第一次创建时，_MyHomePageState类会被创建，
 *当初始化完成后，Flutter框架会调用Widget的build方法来构建widget树，最终将widget树渲染到设备屏幕上。**/
  /**Scaffold 是 Material库中提供的一个widget, 它提供了默认的导航栏、标题和包含主屏幕widget树的body属性。widget树可以很复杂。
      body的widget树中包含了一个Center widget，Center 可以将其子widget树对齐到屏幕中心， Center 子widget是一个Column widget，
      Column的作用是将其所有子widget沿屏幕垂直方向依次排列， 此例中Column包含两个 Text子widget，第一个Text widget显示固定文本
      “You have pushed the button this many times:”，第二个Text widget显示_counter状态的数值。
      floatingActionButton是页面右下角的带“➕”的悬浮按钮，它的onPressed属性接受一个回调函数
      ，代表它被点击后的处理器，本例中直接将_incrementCounter作为其处理函数。**/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                'Platform button tapped $_counter time${ _counter == 1 ? '' : 's' }.',
                style: const TextStyle(fontSize: 17.0)),
            ),
          ),
//          Container(
//            padding: const EdgeInsets.only(bottom: 15.0, left: 5.0),
//            child: Row(
//              children: <Widget>[
//                Image.asset('assets/flutter-mark-square-64.png', scale: 1.5),
//                const Text('Flutter', style: TextStyle(fontSize: 30.0)),
//              ],
//            ),
//          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendFlutterIncrement,
        child: const Icon(Icons.add),
      ),
    );
  }
}
