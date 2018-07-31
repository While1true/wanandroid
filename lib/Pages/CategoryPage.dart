import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flyandroid/Api/Api.dart';
import 'package:flyandroid/Api/Constant.dart';
import 'package:flyandroid/Model/TreeModel.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool _showloading = true;
  TreeBean treeBean;
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (_showloading)
      return Center(
        child: SizedBox(
          height: 4.0,
          child: Theme(
              data: ThemeData(accentColor: Colors.amber),
              child: LinearProgressIndicator()),
        ),
      );
    return Row(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        LimitedBox(
            maxWidth: 100.0,
            child: Card(child: ListView.builder(
                itemCount: treeBean.data.length, itemBuilder: _buildFirst))),
        Expanded(
           child: ListView.builder(itemBuilder: _buildThird,itemCount: 1,),
        )
      ],
    );
  }

  @override
  void didUpdateWidget(CategoryPage oldWidget) {
    if (treeBean == null && Constanct.SELECT_PAGER == Page.CATEGORY_PAGE.index) {
      _request();
    }
  }

  Widget _buildFirst(BuildContext context, int index) {
    Tree tree = treeBean.data[index];
    return InkResponse(
      onTap: () {
        setState(() {
          _selectIndex = index;
        });
      },
      child: Container(
        color: _selectIndex == index ? Colors.grey[300] : Colors.transparent,
        child: Padding(padding: EdgeInsets.all(8.0),child:Text(tree.name,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
                color: Colors.grey[700]))),
      ),
    );
  }

  List<Widget> _buildSecond() {
    List<Widget> widgets = [];
    Tree tree = treeBean.data[_selectIndex];
    tree.children.map((childtree) {
      widgets.add(Card(
          child: InkWell(
        onTap: () {
          _requestArtical(tree);
//             Navigator.push(context, new MaterialPageRoute(builder: (context) =>
//                 GuideChildPage(artical.name, artical)));
        },
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Text(
            childtree.name,
          ),
        ),
      )));
    }).toList();
    return widgets;
  }
  Widget _buildThird(BuildContext context, int index) {
    if (index == 0)
      return Wrap(children: _buildSecond());
      index = index - 1;
      return null;
    }

  Future<Null> _request() async {
    http.Response response = await http.get(Api.TREE);
    treeBean = TreeBean.fromJson(json.decode(response.body));
    setState(() {
      _showloading = false;
    });
    return null;
  }

  void _requestArtical(Tree tree) async {}
}
