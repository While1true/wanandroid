import 'package:flyandroid/Model/Artical.dart';
class HomeData {
  final int errorCode;
  final String errorMsg;
  final _HomeData data;
  HomeData(this.errorMsg,this.errorCode,this.data);
  HomeData.fromJson(Map<String,dynamic>json):
        errorCode=json['errorCode'],
        errorMsg=json['errorMsg'],
        data=_HomeData.fromJson(json['data'] as Map<String,dynamic>);
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
    return articals.map((artical) => Artical.fromJson(artical as Map<String,dynamic>)).toList();
  }
}
