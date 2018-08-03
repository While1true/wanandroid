import 'dart:async';
import 'dart:convert';
import 'package:flyandroid/Model/Artical.dart';
import 'package:flyandroid/Model/HomeModel.dart';
import 'package:flyandroid/Pages/Item/ArticalItem.dart';
import 'package:flyandroid/Utils/CookieUtil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flyandroid/Api/Api.dart';
import 'package:flyandroid/Api/Constant.dart';
import 'package:flyandroid/Model/TreeModel.dart';
import 'package:flyandroid/SelfWidge/Refresh.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool _showloading = true;
  TreeBean treeBean; //分类数据
  int _selectIndex = 0;
  ChildTree _child; //选中的child
  int page = 0;
  HomeData homeData; //文章数据
  bool _isnomore = false;
  List<Artical> _articals = [];

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        LimitedBox(
            maxWidth: 100.0,
            child: Card(
                child: ListView.builder(
                    itemCount: treeBean.data.length,
                    itemBuilder: _buildFirst))),
        Expanded(
          child: RefreshLayout(
            child: ListView.builder(
              itemBuilder: _buildThird,
              itemCount: (_isnomore ? 1 : 0) + _articals.length + 1,
            ),
            onRefresh: (isrefresh) {
              return _requestArtical(isrefresh);
            },
            canloading: !_isnomore,
          ),
        )
      ],
    );
  }

  @override
  void didUpdateWidget(CategoryPage oldWidget) {
    if (treeBean == null &&
        Constanct.SELECT_PAGER == Page.CATEGORY_PAGE.index) {
      _request();
    }
  }

  /**
   * 构建分类
   */
  Widget _buildFirst(BuildContext context, int index) {
    Tree tree = treeBean.data[index];
    return InkResponse(
      onTap: () {
        if (_selectIndex != index) {
          _selectIndex = index;
          _child = tree.children[0];
          _requestArtical(true);
        }
      },
      child: Container(
        color: _selectIndex == index ? Colors.grey[300] : Colors.transparent,
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(tree.name,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: Colors.grey[700]))),
      ),
    );
  }

  /**
   * 构建子分类
   */
  List<Widget> _buildSecond() {
    List<Widget> widgets = [];
    Tree tree = treeBean.data[_selectIndex];
    tree.children.map((childtree) {
      widgets.add(Card(
          child: InkWell(
              onTap: () {
                if (_child != childtree) {
                  _child = childtree;
                  _requestArtical(true);
                }
//             Navigator.push(context, new MaterialPageRoute(builder: (context) =>
//                 GuideChildPage(artical.name, artical)));
              },
              child: Container(
                color:
                    _child == childtree ? Colors.grey[300] : Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    childtree.name,
                  ),
                ),
              ))));
    }).toList();
    return widgets;
  }

  /**
   * 构建文章列表
   */
  Widget _buildThird(BuildContext context, int index) {
    if (index == 0) return Wrap(children: _buildSecond());

    int acturalindex = index - 1;
    if (acturalindex <= _articals.length - 1) {
      return ArticalItem(_articals[acturalindex]);
    }
    return Center(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Text("没有更多了"),
      ),
    );
  }

  /**
   * 请求分类数据
   */
  Future<Null> _request() async {
    try {
      http.Response response = await http.get(Api.TREE);
      treeBean = TreeBean.fromJson(json.decode(response.body));
      _child = treeBean.data[0].children[0];
      _showloading = false;
      _requestArtical(true);
    } catch (e) {
      print(e);
    }
    return null;
  }

  /**
   * 请求文章
   */
  Future<Null> _requestArtical(bool isrefresh) async {
    if (isrefresh) {
      _articals.clear();
      _isnomore = false;
      page = 0;
    } else {
      page += 1;
    }
    http.Response response =
        await http.get(Api.getTreeArtical(page, _child.id),headers: await CookieUtil.getCookie());
    var homeData = HomeData.fromJson(json.decode(response.body));
    if (homeData.errorCode < 0) {
      //TODO
    } else {
      var articals = homeData.data.datas;
      if (articals.length < homeData.data.size) {
        _isnomore = true;
      }
      _articals += articals;

      if (articals.length != 0) {
        setState(() {
        });
      }
    }
    return null;
  }
}
