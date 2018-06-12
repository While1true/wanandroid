import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flyandroid/Api.dart';
import 'package:flyandroid/Model/Artical.dart';
import 'package:flyandroid/Model/HomeModel.dart';
import 'package:flyandroid/SelfWidge/Refresh.dart';
import 'package:flyandroid/SelfWidge/ArticalItem.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  List<Artical> _articals = [];
  int _page = 0;
  bool _isnomore = false;
  ShowState _state = ShowState.LOADING;
  String _error;
@override
  void initState() {
    super.initState();
    _request(_page);
  }
  @override
  Widget build(BuildContext context) {
    switch (_state) {
      case ShowState.LOADING:
        return new Center(child: CircularProgressIndicator(strokeWidth: 1.4,),);
      case ShowState.EMPTY:
        return new Center(child: Text('没有相关信息'),);
      case ShowState.ERROR:
        return new Center(child: Text(_error),);
      case ShowState.CONTENT:
        return RefreshLayout(onRefresh: (isrefresh) {
          if (isrefresh) {
            _page = 0;
          } else {
            _page++;
          }
          return _request(_page);
        }, canloading: !_isnomore,
          child: ListView.builder(
            itemCount: _articals.length,
            itemBuilder: _itemBuild,
          ),
        );
    }
    return null;
  }

  Future<Null> _request(int page) async {
    http.Response response = await http.get(Api.getHomePageUrl(_page));
    print(response.body);
    var homeData = HomeData.fromJson(json.decode(response.body));
    if (homeData.errorCode < 0) {
      _state = ShowState.ERROR;
      _error = homeData.errorMsg;
    } else {
      if(page==0){
        _articals.clear();
      }
      _articals += homeData.data.datas;
      if (page == 0 && _articals.isEmpty) {
        _state = ShowState.EMPTY;
      } else {
        _state = ShowState.CONTENT;
        if (homeData.data.datas.length < homeData.data.size) {
          _isnomore = true;
        }
      }
    }
    setState(() {

    });
    return null;
  }

  Widget _itemBuild(BuildContext context, int index) {
    return ArticalItem(_articals[index]);
  }
}
enum ShowState {
  ERROR,
  LOADING,
  EMPTY,
  CONTENT
}