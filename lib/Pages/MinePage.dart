import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flyandroid/Api/Api.dart';
import 'package:flyandroid/Api/Constant.dart';
import 'package:flyandroid/Model/Artical.dart';
import 'package:flyandroid/Model/HomeModel.dart';
import 'package:flyandroid/Model/UserModel.dart';
import 'package:flyandroid/Pages/Item/ArticalItem.dart';
import 'package:flyandroid/Pages/LoginAndRegisterPage.dart';
import 'package:flyandroid/SelfWidge/Refresh.dart';
import 'package:flyandroid/Utils/CookieUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  List<Artical> _articals = [];
  UserModel model;
  ShowState showState;
  int _page = 0;
  bool _isnomore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showState = ShowState.LOGIN;
  }

  @override
  void didUpdateWidget(MinePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (Constanct.SELECT_PAGER == Page.MINE_PAGE.index && model == null) {
      asyncInit();
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (showState) {
      case ShowState.LOGIN:
        return Center(
          child: new InkWell(
            child: Padding(padding: EdgeInsets.all(50.0), child: Text("点击登录！")),
            onTap: () async {
              var result = await Navigator
                  .of(context)
                  .push(MaterialPageRoute(builder: (c) {
                return LoginAndRegisterPage(LoginAndRegister.LOGIN);
              }));
              if (result) {
                asyncInit();
              }
            },
          ),
        );
      default:
        return RefreshLayout(
          canrefresh: false,
          canloading: !_isnomore,
          child: ListView.builder(
            itemBuilder: listBuilder,
            itemCount: _articals.length + 1,
          ),
          onRefresh: (onrefresh) {
            if (!onrefresh) {
              _page++;
              return doLoading();
            }
          },
        );
    }
  }

  Widget listBuilder(BuildContext b, int position) {
    if (position == 0) {
      return headerBuilder(b);
    }
    return ArticalItem(_articals[position - 1]);
  }

  Widget headerBuilder(BuildContext b) {
    return Card(
        margin: EdgeInsets.all(12.0),
        child: Row(children: <Widget>[
          Image.network(model.data.icon),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "ID:" +
                  model.data.id.toString() +
                  "\n用户名：" +
                  model.data.username +
                  "\nEmail:" +
                  model.data.email,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
          )
        ]));
  }

  void asyncInit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.getString("user");
    if (user != null) {
      model = UserModel.fromJson(json.decode(user));
      doLoading();
    }
  }

  Future<Null> doLoading() async {
    if (_page == 0) {
      _articals.clear();
    }
    http.Response response = await http.get(Api.getCollectList(_page),
        headers: await CookieUtil.getCookie());
    print(response.body);
    var homeData = HomeData.fromJson(json.decode(response.body));
    if (homeData.errorCode == 0) {
      _articals += homeData.data.datas;
      if (homeData.data.datas.length < homeData.data.size) {
        _isnomore = true;
      }
      setState(() {
        showState = ShowState.CONTENT;
      });
    } else {
      print(homeData.errorMsg);
    }

    return new Future<Null>.value(null);
  }
}

enum ShowState { LOGIN, CONTENT }
