import 'dart:async';
import 'package:flyandroid/Model/Artical.dart';
import 'package:flyandroid/Model/GuideModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flyandroid/Api/Api.dart';
import 'package:flutter/material.dart';

class GuidePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  bool _showloading = true;
  GuideData guideData;

  @override
  Widget build(BuildContext context) {
    if (_showloading)
      return Center(
        child: SizedBox(height: 4.0,child:Theme(data: ThemeData(accentColor: Colors.amber), child: LinearProgressIndicator()),),
      );
    return SingleChildScrollView(
      child: Wrap(
        children: _buildchild(),
      ),
    );
  }

  List<Widget> _buildchild() {
    List<Widget> temps = [];
    List<Guide> guides = guideData.data;
    guides.map((artical) {
      temps.add(Card(
          child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Text(
            artical.name + " (${artical.articles.length})",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
                color: Colors.grey[700]),
          ),
        ),
      )));
    }).toList();

    return temps;
  }

  @override
  void didUpdateWidget(GuidePage oldWidget) {
    if(guideData==null){
      _request();
    }
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
