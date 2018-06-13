import 'package:flyandroid/Model/Artical.dart';

class HomeData {
  final int errorCode;
  final String errorMsg;
  final _HomeData data;

  HomeData(this.errorMsg, this.errorCode, this.data);

  HomeData.fromJson(Map<String, dynamic>json)
      :
        errorCode=json['errorCode'],
        errorMsg=json['errorMsg'],
        data=_HomeData.fromJson(json['data'] as Map<String, dynamic>);
}

class _HomeData {
  final int curPage;
  final int size;
  final int total;
  final int pageCount;
  final List<Artical>datas;

  _HomeData(this.curPage, this.size, this.total, this.pageCount, this.datas);

  _HomeData.fromJson(Map<String, dynamic> json)
      :
        curPage=json['curpage'],
        size=json['size'],
        total=json['total'],
        pageCount=json['pageCount'],
        datas=getArticals(json['datas']);


  static List<Artical> getArticals(List<dynamic> articals) {
    return articals.map((artical) =>
        Artical.fromJson(artical as Map<String, dynamic>)).toList();
  }
}

class BannerData {
  final int errorCode;
  final String errorMsg;
  final List<_BannerData> data;

  BannerData(this.errorMsg, this.errorCode, this.data);

  BannerData.fromJson(Map<String, dynamic>json)
      :
        errorCode=json['errorCode'],
        errorMsg=json['errorMsg'],
        data=_getBannerDatas(json['data']);

  static List<_BannerData> _getBannerDatas(List<dynamic> jsons) {
    return jsons.map((banner) => _BannerData.fromJson(banner as Map<String, dynamic>)).toList();
  }

}

class _BannerData {
  final String desc;
  final String imagePath;
  final String title;
  final String url;
  final int isVisible;
  final int order;
  final int type;
  final int id;
  _BannerData.fromJson(Map<String, dynamic> json)
      :
        desc=json['desc'],
        imagePath=json['imagePath'],
        title=json['title'],
        url=json['url'],
        isVisible=json['isVisible'],
        order=json['order'],
        id=json['id'],
        type=json['type'];
}
