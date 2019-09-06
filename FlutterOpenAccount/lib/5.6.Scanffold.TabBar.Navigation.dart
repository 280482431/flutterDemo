import 'package:flutter/material.dart';

class TabBarNavgationApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: new ScaffoldRoute(),
    );
  }
}

class ScaffoldRoute extends StatefulWidget{
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute>
    with SingleTickerProviderStateMixin{
  TabController _tabController; //需要定义一个Controller
  List tabs = ["新闻", "历史", "图片"];

   @override
   void initState(){
     super.initState();
     // 创建Controller
     _tabController = TabController(length: tabs.length, vsync: this);
     _tabController.addListener((){
       switch(_tabController.index){
         case 1: print("1");break;
         case 2: print("2");break;
         case 3: print("3");break;
       }
     });
   }

  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar( //导航栏
        title: Text("ScaffoldRoute"),
        actions: <Widget>[ //导航栏右侧菜单
          IconButton(icon: Icon(Icons.share), onPressed: null),
        ],
        bottom: TabBar(   //生成Tab菜单
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList()
        ),
      ),

      drawer: new MyDrawer(),//抽屉

      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e){//创建3个Tab页
          return Container(
          alignment: Alignment.center,
        child: Text(e, textScaleFactor: 5),
      );
        }).toList(),
      ),

      bottomNavigationBar:BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),// 底部导航栏打一个圆形的洞
        child: Row(
          children: <Widget>[
            IconButton(icon:Icon(Icons.home), onPressed: null),
            SizedBox(),//中间位置空出
            IconButton(icon: Icon(Icons.business), onPressed: null),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,//均分底部导航栏横向空间
        ),
      ),
//      BottomNavigationBar(
//        items: <BottomNavigationBarItem>[ // 底部导航
//          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.business), title: Text("business")),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.school), title: Text("school")),
//        ],
//        currentIndex: _selectedIndex,
//        fixedColor: Colors.blue,
//        onTap: _onItemTapped,
//      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,//放到洞里
      floatingActionButton: FloatingActionButton(//悬浮按钮
          child: Icon(Icons.add), onPressed: _onAdd), //悬浮按钮
    );
  }
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    void _onAdd() {
     print("Add");
  }
}

class MyDrawer extends StatelessWidget{
  const MyDrawer({
    Key key,
  }):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                       child: Image.asset("graphics/CHN.png",width: 80,),
                    ),
                  ),
                  Text("Wendux",style: TextStyle(fontWeight: FontWeight.bold),
                  )
                 ],
                ),
              ),

              Expanded(
                child: ListView(children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text("Add account"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Manage accounts"),
                  )
                ],)),
            ],
        )),
    );
  }
}