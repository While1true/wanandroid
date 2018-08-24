import 'dart:async';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';

class MyWebPage extends StatefulWidget {
  final String url;
  final String title;

  MyWebPage(this.url, this.title);

  @override
  State<StatefulWidget> createState() => _WebState();
}

class _WebState extends State<MyWebPage> {
  final flutterWebViewPlugin = new FlutterWebviewPlugin();
  bool isloading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterWebViewPlugin.onDestroy.listen((onDestroy){
      Navigator.pop(context);
    });
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad&&isloading) {
        setState(() {
          isloading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _toppadding = MediaQuery.of(context).padding.top;
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        WebviewScaffold(
          url: widget.url,
          appBar: AppBar(
            title: Text(
              widget.title,
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          withJavascript: true,
          withLocalStorage: true,
          withZoom: true,
        ),
        Offstage(
          offstage: !isloading,
          child: Padding(
            padding: EdgeInsets.only(top: (kToolbarHeight + _toppadding - 2)),
            child: new LinearProgressIndicator(
              backgroundColor: Colors.amber,
            ),
          ),
        )
      ],
    );
  }
}
