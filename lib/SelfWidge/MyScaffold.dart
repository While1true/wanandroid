import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';

/**
 *   ________________
 *  |______888_____ |
 *  ||            ||
 *  ||            ||
 *  ||            ||
 *  ||____________||
 *  |___|__|___|___|
 *
 *
 *
 */
class MaterialScaffod extends StatefulWidget {
  final int index;
  final double iconSize;
  final AppBar appBar;
  final itembars;
  final Key key;
  final List<Widget> childrenContent;
  final ValueChanged<int> onIndexChanged;
  final MaterialScaffodType materialScaffodType;

  const MaterialScaffod(
      {this.appBar, this.iconSize = 24.0, this.materialScaffodType = MaterialScaffodType
          .STACK, this.index, this.onIndexChanged, @required this.childrenContent, @required this.itembars ,this.key}):super(key:key);


  @override
  State<StatefulWidget> createState() {
    switch (materialScaffodType) {
      case MaterialScaffodType.STACK:
        return _MaterialScaffodStack();
      case MaterialScaffodType.PAGE:
        return _MaterialPagerState();
      case MaterialScaffodType.INDICATED:
        return _MaterialIndicateState();
      default:
        return _MaterialScaffodStack();
    }
  }


}
enum MaterialScaffodType {
  /**
   * 只绘制一页不能滑动
   */
  STACK,
  /**
   * 绘制多页可以滑动
   */
  PAGE,

  /**
   * 在上面
   */
  INDICATED
}

class _MaterialScaffodStack extends State<MaterialScaffod> {
  int _index;

  @override
  void initState() {
    super.initState();
    _index = (widget.index == null ? 0 : widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: widget.appBar,
        bottomNavigationBar: BottomNavigationBar(iconSize: widget.iconSize,
            currentIndex: _index,
            items: widget.itembars,
            onTap: (index) {
              if (widget.onIndexChanged != null) {
                widget.onIndexChanged(index);
              }
              setState(() {
                _index = index;
              });
            },
            type: BottomNavigationBarType.fixed),
        body: IndexedStack(key: GlobalKey(),
          index: _index, children: widget.childrenContent,));
  }

}

class _MaterialPagerState extends State<MaterialScaffod> {
  int _index;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _index = (widget.index == null ? 0 : widget.index);
    _controller = new PageController(initialPage: _index);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: widget.appBar,
        bottomNavigationBar: BottomNavigationBar(key: widget.key,
            iconSize: widget.iconSize,
            currentIndex: _index,
            items: widget.itembars,
            onTap: (index) {
              _controller.jumpToPage(index);
            },
            type: BottomNavigationBarType.fixed),
        body: PageView(key: GlobalKey(),
          controller: _controller,
          children: widget.childrenContent,
          onPageChanged: (page) {
            widget.onIndexChanged(page);
            setState(() {
              _index = page;
            });
          },));
  }

}

class _MaterialIndicateState extends State<MaterialScaffod>
    implements TickerProvider {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController =
    new TabController(length: widget.itembars.length, vsync: this);
    _tabController.addListener(call);
  }

  @override
  void dispose() {
    _tabController.removeListener(call);
  }

  void call() {
    if(widget.onIndexChanged!=null){
      widget.onIndexChanged(_tabController.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar: widget.appBar, body: new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TabBar(indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          tabs: widget.itembars,
          labelColor: Theme
              .of(context)
              .primaryColor,
          controller: _tabController,),
        new Expanded(child: new TabBarView(
            controller: _tabController, children: widget.childrenContent),)
      ],
    ));
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return new Ticker(onTick);
  }


}