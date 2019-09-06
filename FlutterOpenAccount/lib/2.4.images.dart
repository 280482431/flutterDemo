// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

/** 通过rootBundle 对象加载：每个Flutter应用程序都有一个rootBundle对象， 通过它可以轻松访问主资源包，直接使用package:flutter/services.dart中全局静态的rootBundle对象来加载asset即可。
通过 DefaultAssetBundle 加载：建议使用 DefaultAssetBundle 来获取当前BuildContext的AssetBundle。 这种方法不是使用应用程序构建的默认asset bundle，而是使父级widget在运行时动态替换的不同的AssetBundle，这对于本地化或测试场景很有用。
通常，可以使用DefaultAssetBundle.of()在应用运行时来间接加载asset（例如JSON文件），而在widget上下文之外，或其它AssetBundle句柄不可用时，可以使用rootBundle直接加载这些asset，*/
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/config.json');
}

class AssetImageApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
//    return DefaultAssetBundle.of('graphics/bankcard.png');
//    return DefaultAssetBundle.of(Image.asset('graphics/bankcard.png'));
//    return Image.asset('graphics/bankcard.png');
//    return new DecoratedBox(
//      decoration: new BoxDecoration(
//        image: new DecorationImage(
//          image: new AssetImage('/graphics/bankcard.png'),
//        )
//      ),
//    );
  }
}