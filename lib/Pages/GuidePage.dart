import 'dart:async';
import 'package:flyandroid/Model/Artical.dart';
import 'package:flyandroid/Model/GuideModel.dart';
import 'package:flyandroid/Pages/WebPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flyandroid/Api/Api.dart';
import 'package:flyandroid/Api/Constant.dart';
import 'package:flutter/material.dart';

class GuidePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  bool _showloading = true;
  GuideData guideData;
  int _selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (_showloading)
      return Center(
        child: SizedBox(height: 4.0,child:Theme(data: ThemeData(accentColor: Colors.amber), child: LinearProgressIndicator()),),
      );
    return Row(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        LimitedBox(
            maxWidth: 100.0,
            child: Card(child: ListView.builder(
                itemCount: guideData.data.length, itemBuilder: _buildFirst))),
        Expanded(
          child:Wrap(children: _buildSecond()),
        )
      ],
    );
  }
  Widget _buildFirst(BuildContext context, int index) {
    Guide tree = guideData.data[index];
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
    Guide tree = guideData.data[_selectIndex];
    tree.articles.map((childtree) {
      widgets.add(Card(
          child: InkWell(
            onTap: () {
              _click(childtree);
//             Navigator.push(context, new MaterialPageRoute(builder: (context) =>
//                 GuideChildPage(artical.name, artical)));
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                childtree.title,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          )));
    }).toList();
    return widgets;
  }
  @override
  void didUpdateWidget(GuidePage oldWidget) {
    if(guideData==null&&Constanct.SELECT_PAGER==Page.GUIDE_PAGE.index){
      _request();
    }
  }
  void _click(Artical artical) {
    Navigator.push(context, new MaterialPageRoute(builder: (context) =>
        MyWebPage(artical.link, artical.title)));
  }
  Future<Null> _request() async {
    http.Response response = await http.get(Api.NAVIGATION);
    print(response);
    guideData = GuideData.fromJson(json.decode(response.body));
    setState(() {
      _showloading = false;
    });
    return null;
  }
}
