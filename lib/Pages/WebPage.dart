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
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isloading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(url: widget.url,
      appBar:
      AppBar(title:Text(widget.title, style: TextStyle(fontSize: 15.0),),),
      withJavascript: true,
      withLocalStorage: false,);
  }

}