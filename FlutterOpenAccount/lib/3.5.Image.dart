import 'package:flutter/material.dart';
/*Flutter框架对加载过的图片是有缓存的（内存），默认最大缓存数量是1000，最大缓存空间为100M。*/
/*Flutter中，可以像Web开发一样使用iconfont，iconfont即“字体图标”，它是将图标做成字体文件，
然后通过指定不同的字符而显示不同的图片。
在字体文件中，每一个字符都对应一个位码，而每一个位码对应一个显示字形，不同的字体就是指字形不同，
即字符对应的字形是不同的。而在iconfont中，只是将位码对应的字形做成了图标，所以不同的字符最终就会渲染成不同的图标。
在Flutter开发中，iconfont和图片相比有如下优势：
体积小：可以减小安装包大小。
矢量的：iconfont都是矢量图标，放大不会影响其清晰度。
可以应用文本样式：可以像文本一样改变字体图标的颜色、大小对齐等。
可以通过TextSpan和文本混用。*/

class ImageApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return MaterialApp(
//      home: ImageAndIconRoute(),
      home: IconDatas(),
    );
  }
}

class ImageAndIconRoute extends StatelessWidget {
  var img = AssetImage("graphics/HK.png");
  var url = "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
        child: Column(
            children: <Image>[
              Image(
                image: img,
                width: 100.0,
              ),
              Image(
                image: NetworkImage(url),
                width: 100.0,
              ),
              Image.network(
                url,
                width: 100.0,
              ),
              Image(
                image: img,
                height: 50.0,
                width: 100.0,
                fit: BoxFit.fill,
              ),
              Image(
                image: img,
                height: 50.0,
                width: 50.0,
                fit: BoxFit.contain,
              ),
              Image(
                image: img,
                width: 100.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
              Image(
                image: img,
                width: 100.0,
                height: 50.0,
                fit: BoxFit.fitWidth,
              ),
              Image(
                image: img,
                width: 100.0,
                height: 50.0,
                fit: BoxFit.fitHeight,
              ),
              Image(
                image: img,
                width: 100.0,
                height: 50.0,
                fit: BoxFit.scaleDown,
              ),
              Image(
                image: img,
                width: 100.0,
                height: 50.0,
                fit: BoxFit.none,
              ),
              Image(
                image: img,
                width: 100.0,
                height: 50.0,
                color: Colors.blue,
                colorBlendMode: BlendMode.difference,
                fit: BoxFit.fill,
              ),
              Image(
                image: img,
                width: 100.0,
                height: 50.0,
                repeat: ImageRepeat.repeatY,
              )
            ].map((e){
              return Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 100,
                      child: e,
                    ),
                  ),
                  Text(e.fit.toString())
                ],
              );
            }).toList()
        ),
    );
  }
}

//系统字体图标
class IconDatas extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.accessibility,color: Colors.blue,),
        Icon(Icons.error,color: Colors.blue,),
        Icon(Icons.fingerprint,color: Colors.blue,),
        Icon(MyIconss.book,color: Colors.blue,),
        Icon(MyIconss.wechat,color: Colors.blue,),
      ],
    );
  }
}

class MyIconss{
  static const IconData book = const IconData(
      0xe76a,
      fontFamily: 'myIcon',
      matchTextDirection: true
  );

  static const IconData wechat = const IconData(
    0xe614,
    fontFamily: 'myIcon',
    matchTextDirection: true
  );
}

/*自定义字体图标
*fonts:
  - family: myIcon  #指定一个字体名
    fonts:
      - asset: fonts/iconfont.ttf
*
* 为了使用方便，我们定义一个MyIcons类，功能和Icons类一样：将字体文件中的所有图标都定义成静态变量：
* class MyIcons{
  // book 图标
  static const IconData book = const IconData(
      0xe614,
      fontFamily: 'myIcon',
      matchTextDirection: true
  );
  // 微信图标
  static const IconData wechat = const IconData(
      0xec7d,
      fontFamily: 'myIcon',
      matchTextDirection: true
  );
}
*
* Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Icon(MyIcons.book,color: Colors.purple,),
    Icon(MyIcons.wechat,color: Colors.green,),
  ],
)
*
*/