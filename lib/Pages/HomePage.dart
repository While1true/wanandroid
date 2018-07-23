import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flyandroid/Api/Api.dart';
import 'package:flyandroid/Model/Artical.dart';
import 'package:flyandroid/Model/HomeModel.dart';
import 'package:flyandroid/SelfWidge/Refresh.dart';
import 'package:flyandroid/Pages/Item/ArticalItem.dart';
import 'package:flyandroid/Pages/WebPage.dart';
import 'package:flyandroid/SelfWidge/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Artical> _articals = [];
  BannerData _banner;
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
        return Center(
          child: SizedBox(
            height: 4.0,
            child: Theme(
                data: ThemeData(accentColor: Colors.amber),
                child: LinearProgressIndicator()),
          ),
        );
      case ShowState.EMPTY:
        return new Center(
          child: Text('没有相关信息'),
        );
      case ShowState.ERROR:
        return new Center(
          child: Text(_error),
        );
      case ShowState.CONTENT:
        return RefreshLayout(
          onRefresh: (isrefresh) {
            if (isrefresh) {
              _page = 0;
            } else {
              _page++;
            }
            return _request(_page);
          },
          canloading: !_isnomore,
          child: ListView.builder(
            itemCount:
                _banner == null ? _articals.length : _articals.length + 1,
            itemBuilder: _itemBuild,
          ),
        );
    }
    return null;
  }

  Future<Null> _request(int page) async {
    http.Response response = await http.get(Api.getHomePageUrl(_page));
    http.Response bannerResponse = await http.get(Api.BANNER);
    _banner = BannerData.fromJson(json.decode(bannerResponse.body));
    var homeData = HomeData.fromJson(json.decode(response.body));
    if (homeData.errorCode < 0) {
      _state = ShowState.ERROR;
      _error = homeData.errorMsg;
    } else {
      if (page == 0) {
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
    setState(() {});
    return null;
  }

  Widget _itemBuild(BuildContext context, int index) {
    if (index == 0 && _banner != null) {
      return new CarouselSlider(
          items: _banner.data.map((banner) {
            return new Builder(
              builder: (BuildContext context) {
                return new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: new EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 5.0),
                    child: GestureDetector(
                      onTap: () {
                        _bannerClick(banner.url, banner.title);
                      },
                      child: Stack(
                        children: <Widget>[
                          new Container(
                            margin: new EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(15.0)),
                                image: new DecorationImage(
                                    image: new NetworkImage(banner.imagePath),
                                    fit: BoxFit.cover)),
                          ),
                          Align(
                            child: DecoratedBox(
                              decoration:
                                  BoxDecoration(color: Color(0xAAffffff)),
                              child: Text(banner.title),
                            ),
                            alignment: Alignment.bottomCenter,
                          )
                        ],
                      ),
                    ));
              },
            );
          }).toList(),
          viewportFraction: 0.9,
          aspectRatio: 2.0,
          autoPlay: true);
    }
    return ArticalItem(_articals[_banner == null ? index : index - 1]);
  }

  void _bannerClick(String link, String title) {
    Navigator
        .of(context)
        .push(MaterialPageRoute(builder: (context) => MyWebPage(link, title)));
  }
}

enum ShowState { ERROR, LOADING, EMPTY, CONTENT }
