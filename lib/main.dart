import 'package:flutter/material.dart';
import 'package:flyandroid/SelfWidge/MyScaffold.dart';
import 'package:flyandroid/Pages/HomePage.dart';
import 'package:flyandroid/Pages/GuidePage.dart';
import 'package:flyandroid/Pages/CategoryPage.dart';
import 'package:flyandroid/Pages/MinePage.dart';
import 'package:flyandroid/Api/Constant.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fly Android 你的玩Android',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
      },
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key}) : super(key: key);

  final titles = ['首页', '分类', '导航', '我的'];

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialScaffod(
      appBar: AppBar(title: Text(widget.titles[_index]),
        /*actions: _index < 2 ? <Widget>[
          new FlatButton.icon(icon: Icon(Icons.search,color: Colors.white,),label: Text('搜索',style: TextStyle(color: Colors.white),), onPressed: _jumpSearch)
        ] : null,*/),
      materialScaffodType: MaterialScaffodType.STACK,
      childrenContent: <Widget>[

        HomePage(),

        CategoryPage(),

        GuidePage(),

        MinePage()

      ],
      itembars: <BottomNavigationBarItem>[

        BottomNavigationBarItem(
            title: Text(widget.titles[0]), icon: Icon(Icons.home)),

        BottomNavigationBarItem(
            title: Text(widget.titles[1]), icon: Icon(Icons.category)),

        BottomNavigationBarItem(
            title: Text(widget.titles[2]), icon: Icon(Icons.blur_circular)),

        BottomNavigationBarItem(
            title: Text(widget.titles[3]), icon: Icon(Icons.account_circle))
      ],
      onIndexChanged: (index) {
        setState(() {
          Constanct.SELECT_PAGER=index;
          this._index = index;
        });
      },
    );
  }

  void _jumpSearch() {
    Navigator.of(context).pushNamed("/search");
  }
}
