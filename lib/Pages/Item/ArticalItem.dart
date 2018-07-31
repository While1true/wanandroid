import 'package:flutter/material.dart';
import 'package:flyandroid/Model/Artical.dart';
import 'package:flyandroid/Pages/WebPage.dart';

class ArticalItem extends StatefulWidget {
  final Artical artical;

  ArticalItem(this.artical);

  @override
  State<StatefulWidget> createState() => ArticalState();
}

class ArticalState extends State<ArticalItem> {
  String escapeFromHtml(String html) {
    String temp = html.replaceAll("&mdash;", "-").replaceAll("&ndash;", "-");
    String temp2 = temp.replaceAll("&ldquo;", "“");
    String temp3 = temp2.replaceAll("&rdquo;", "”");
    return temp3;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: _onTap,
      child: Stack(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(16.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 32.0),
                      child: Hero(
                        tag: widget.artical.title,
                        child: Text(escapeFromHtml(widget.artical.title),
                            softWrap: true,
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                color: Colors.grey[700])),
                      )),
                  widget.artical.envelopePic == ""
                      ? Padding(
                          padding: EdgeInsets.all(1.0),
                        )
                      : Image.network(
                          widget.artical.envelopePic,
                          height: 200.0,
                        ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Wrap(
                      spacing: 8.0,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: _buildWidge(),
                    ),
                  )
                ],
              )),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: _collect,
              icon: Icon(
                widget.artical.collect ? Icons.favorite : Icons.favorite_border,
                color: widget.artical.collect ? Colors.redAccent : Colors.grey,
              ),
            ),
          )
        ],
      ),
    ));
  }

  List<Widget> _buildWidge() {
    var widges = <Widget>[];
    if (widget.artical.fresh) {
      widges.add(DecoratedBox(
          child: Padding(
            padding: EdgeInsets.all(1.0),
            child: Text(
              "新",
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          decoration: new ShapeDecoration(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.red)))));
    }
    widget.artical.tags.map((tag) {
      widges.add(GestureDetector(
        child: DecoratedBox(
            child: Padding(
              padding: EdgeInsets.all(1.0),
              child: Text(tag.name),
            ),
            decoration: new ShapeDecoration(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green)))),
        onTap: () {
          _onClickTag(tag);
        },
      ));
    });

    widges.add(Text("作者：" + widget.artical.author,
        style: TextStyle(fontSize: 13.0, color: Colors.grey)));
    widges.add(GestureDetector(
      child: Text(
        widget.artical.superChapterName,
        style: TextStyle(
            color: Colors.blueGrey,
            fontStyle: FontStyle.italic,
            fontSize: 12.0),
      ),
      onTap: _onCategoryClick,
    ));

    widges.add(GestureDetector(
      child: Text(widget.artical.chapterName,
          style: TextStyle(
              color: Colors.blueGrey,
              fontStyle: FontStyle.italic,
              fontSize: 12.0)),
      onTap: _onCategoryClick2,
    ));

    widges.add(Text(widget.artical.niceDate,
        style: TextStyle(fontSize: 13.0, color: Colors.grey)));

    return widges;
  }

  void _onTap() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            MyWebPage(widget.artical.link, widget.artical.title)));
  }

  void _onCategoryClick() {
    Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("还未实现该功能"),
        ));
  }

  void _onCategoryClick2() {
    Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("还未实现该功能"),
        ));
  }

  void _onClickTag(Tag tag) {}

  void _collect() {
    print('collect');
    setState(() {
      widget.artical.collect = !widget.artical.collect;
    });
  }
}
