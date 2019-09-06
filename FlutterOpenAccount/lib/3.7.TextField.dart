import 'package:flutter/material.dart';

/*
* controller：编辑框的控制器，通过它可以设置/获取编辑框的内容、选择编辑内容、监听编辑文本改变事件。
* 大多数情况下我们都需要显式提供一个controller来与文本框交互。如果没有提供controller，则TextField内部会自动创建一个。

focusNode：用于控制TextField是否占有当前键盘的输入焦点。它是我们和键盘交互的一个句柄（handle）。

InputDecoration：用于控制TextField的外观显示，如提示文本、背景颜色、边框等。

keyboardType：用于设置该输入框默认的键盘输入类型
*
*textInputAction：键盘动作按钮图标(即回车键位图标)，它是一个枚举值，有多个可选值，全部的取值列表读者可以查看API文档
*
*style：正在编辑的文本样式。

textAlign: 输入框内编辑文本在水平方向的对齐方式。

autofocus: 是否自动获取焦点。

obscureText：是否隐藏正在编辑的文本，如用于输入密码的场景等，文本内容会用“•”替换。

maxLines：输入框的最大行数，默认为1；如果为null，则无行数限制。

maxLength和maxLengthEnforced ：maxLength代表输入框文本的最大长度，设置后输入框右下角会显示输入的文本计数。maxLengthEnforced决定当输入文本长度超过maxLength时是否阻止输入，为true时会阻止输入，为false时不会阻止输入但输入框会变红。

onChange：输入框内容改变时的回调函数；注：内容改变事件也可以通过controller来监听。

onEditingComplete和onSubmitted：这两个回调都是在输入框输入完成时触发，比如按了键盘的完成键（对号图标）或搜索键（🔍图标）。不同的是两个回调签名不同，onSubmitted回调是ValueChanged<String>类型，它接收当前输入内容做为参数，而onEditingComplete不接收参数。

inputFormatters：用于指定输入格式；当用户输入内容改变时，会根据指定的格式来校验。

enable：如果为false，则输入框会被禁用，禁用状态不接收输入和事件，同时显示禁用态样式（在其decoration中定义）。

cursorWidth、cursorRadius和cursorColor：这三个属性是用于自定义输入框光标宽度、圆角和颜色的。
*
* */

class TextFieldApp1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Center(
        child: TextFieldAppful(),
      ),
    );
  }
}

class TextFieldAppful extends StatefulWidget{
  @override
  TextFieldState1 createState() => TextFieldState1();
}

class TextFieldState1 extends State<TextFieldAppful>{
  /*获取输入内容*/
  TextEditingController namectl = new TextEditingController();
  TextEditingController pswctl = new TextEditingController();
  /*控制焦点*/
  FocusNode namefocus = new FocusNode();
  FocusNode pswfocus = new FocusNode();
  FocusScopeNode focusscopenode;
  //
  GlobalKey formKey = new GlobalKey<FormState>();//FormState

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    namectl.addListener((){
      print("controller监听");
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Test"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 24.0),
          child: Form(
            key: formKey,//设置globalKey，用于后面获取FormState
              autovalidate: true,//开启自动校验
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autovalidate: true,/*自动检验*/
                    controller: namectl,
                    focusNode: namefocus,//关联focusNode
                    /*decoration中可以设置hintStyle，它可以覆盖hintColor，
                    并且主题中可以通过inputDecorationTheme来设置输入框默认的decoration*/
                    decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      icon: Icon(Icons.person)
                    ),
                    validator: (v){// 校验用户名
                      return v
                          .trim()
                          .length > 0 ? null : "用户名不能为空";
                    },
                  ),
                  TextFormField(
                    controller: pswctl,
                    focusNode: pswfocus,//关联focusNode
                    decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "您的登录密码",
                      icon: Icon(Icons.lock)
                    ),
                    obscureText: true,
                    validator: (v){//校验密码
                      return v
                          .trim()
                          .length > 5 ? null : "密码不能少于6位";
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                              padding: EdgeInsets.all(15.0),
                                child: Text("登录"),
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                textColor: Colors.white,
                                onPressed: (){
                                  //在这里不能通过此方式获取FormState，context不对
                                  //print(Form.of(context));

                                  // 通过_formKey.currentState 获取FormState后，
                                  // 调用validate()方法校验用户名密码是否合法，校验
                                  // 通过后再提交数据。
                                if((formKey.currentState as FormState).validate()){
                                  //验证通过提交数据
                                  //将焦点从第一个TextField移到第二个TextField
                                  // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                                  // 这是第二种写法

                                  // 当所有编辑框都失去焦点时键盘就会收起
                                  namefocus.unfocus();
                                  pswfocus.unfocus();//失去焦点
                                }
                        })),
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: RaisedButton(
                                      padding:EdgeInsets.all(15.0),
                                      child: Text(""),
                                      color: Theme
                                      .of(context)
                                      .primaryColor,
                                textColor: Colors.blue
                                      ,onPressed: (){
                                    //将焦点从第一个TextField移到第二个TextField
                                    // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                                    // 这是第二种写法
                                    if(null == focusscopenode){
                                      focusscopenode = FocusScope.of(context);//获取焦点控制
                                    }
                                    focusscopenode.requestFocus(pswfocus);//成为焦点
                              }))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
      ),
    );
  }
}


/*
*获取输入内容有两种方式：
1。定义两个变量，用于保存用户名和密码，然后在onChange触发时，各自保存一下输入内容。
2。通过controller直接获取。
*
* 监听文本变化也有两种方式：设置onChange回调和通过controller.addListener监听
*
*控制焦点：FocusScope...
// 创建 focusNode
FocusNode focusNode = new FocusNode();
...
// focusNode绑定输入框
TextField(focusNode: focusNode);
...
// 监听焦点变化
focusNode.addListener((){
   print(focusNode.hasFocus);
});
*
*自定义样式decoration：一些样式如下划线默认颜色及宽度都是不能直接自定义的
*由于TextField在绘制下划线时使用的颜色是主题色里面的hintColor，但提示文本颜色也是用的hintColor，
 *  如果我们直接修改hintColor，那么下划线和提示文本的颜色都会变。值得高兴的是decoration中可以设置hintStyle，
 *  它可以覆盖hintColor，并且主题中可以通过inputDecorationTheme来设置输入框默认的decoration
*Theme(
  data: Theme.of(context).copyWith(
      hintColor: Colors.grey[200], //定义下划线颜色
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.grey),//定义label字体样式
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0)//定义提示文本样式
      )
  ),
*
*labelText不会高亮显示了
*另一种灵活的方式是直接隐藏掉TextField本身的下划线，然后通过Container去嵌套定义样式
*Container(
  child: TextField(
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
        labelText: "Email",
        hintText: "电子邮件地址",
        prefixIcon: Icon(Icons.email),
        border: InputBorder.none //隐藏下划线
    )
  ),
  decoration: BoxDecoration(
      // 下滑线浅灰色，宽度1像素
      border: Border(bottom: BorderSide(color: Colors.grey[200], width: 1.0))
  ),
)
*
* 表单Form
*autovalidate：是否自动校验输入内容；当为true时，每一个子FormField内容发生变化时都会自动校验合法性，并直接显示错误信息。否则，需要通过调用FormState.validate()来手动校验。
onWillPop：决定Form所在的路由是否可以直接返回（如点击返回按钮），该回调返回一个Future对象，如果Future的最终结果是false，则当前路由不会返回；如果为true，则会返回到上一个路由。此属性通常用于拦截返回按钮。
onChanged：Form的任意一个子FormField内容发生变化时会触发此回调。
*
* FormField
*const FormField({
  ...
  FormFieldSetter<T> onSaved, //保存回调
  FormFieldValidator<T>  validator, //验证回调
  T initialValue, //初始值
  bool autovalidate = false, //是否自动校验。
})
*
*
*FormState
*FormState为Form的State类，可以通过Form.of()或GlobalKey获得。我们可以通过它来对Form的子孙FormField进行统一操作。我们看看其常用的三个方法：

FormState.validate()：调用此方法后，会调用Form子孙FormField的validate回调，如果有一个校验失败，则返回false，所有校验失败项都会返回用户返回的错误提示。
FormState.save()：调用此方法后，会调用Form子孙FormField的save回调，用于保存表单内容
FormState.reset()：调用此方法后，会将子孙FormField的内容清空。
*
*
*
*
*
 */

