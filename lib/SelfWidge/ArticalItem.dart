import 'package:flutter/material.dart';
import 'package:flyandroid/Model/Artical.dart';

class ArticalItem extends StatelessWidget {
  final Artical artical;

  ArticalItem(this.artical);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: _onTap, child: Padding(padding: EdgeInsets.all(8.0), child:
      new Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(artical.title, softWrap: true,
            maxLines: 2,
            style: TextStyle(fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xff535353)),),

          Padding(padding: EdgeInsets.only(top: 12.0),
            child: Wrap(
              spacing: 8.0, crossAxisAlignment: WrapCrossAlignment.center,
              children:_buildWidge(),),)
        ],))),);
  }

  List<Widget> _buildWidge() {
    var widges = <Widget>[];
    if (artical.fresh) {
      widges.add(DecoratedBox(
          child: Padding(padding: EdgeInsets.all(1.0), child: Text("新"),),
          decoration: new ShapeDecoration(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.red)))));
    }
    artical.tags.map((tag) {
      widges.add(GestureDetector(child: DecoratedBox(
          child: Padding(padding: EdgeInsets.all(1.0), child: Text(tag.name),),
          decoration: new ShapeDecoration(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.green)))), onTap: () {
        _onClickTag(tag);
      },));
    });


    widges.add(Text("作者：" + artical.author));
    widges.add(GestureDetector(
      child: Text(artical.superChapterName, style: TextStyle(
          color: Colors.blue, fontStyle: FontStyle.italic),),
      onTap: _onCategoryClick,));

    widges.add(GestureDetector(
      child: Text(artical.chapterName, style: TextStyle(
          color: Colors.blue, fontStyle: FontStyle.italic)),
      onTap: _onCategoryClick2,));

    widges.add(Text(artical.niceDate));


    return widges;
  }

  _onTap() {

  }

  _onCategoryClick() {

  }

  _onCategoryClick2() {

  }

  _onClickTag(Tag tag) {

  }
}
