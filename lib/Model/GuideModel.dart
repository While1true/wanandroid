import 'package:flyandroid/Model/Artical.dart';

class GuideData {
  final int errorCode;
  final String errorMsg;
  final List<Guide> data;

  GuideData(this.errorMsg, this.errorCode, this.data);

  GuideData.fromJson(Map<String, dynamic> json)
      : errorCode = json['errorCode'],
        errorMsg = json['errorMsg'],
        data = getGuides(json['data'] as List<dynamic>);

  static List<Guide> getGuides(List<dynamic> guides) {
    return guides
        .map((guide) => Guide.fromJson(guide as Map<String, dynamic>))
        .toList();
  }
}

class Guide {
  final List<Artical> articles;
  final String name;
  final int cid;

  Guide(this.name, this.cid, this.articles);

  Guide.fromJson(Map<String, dynamic> json)
      : articles = getArticals(json['articles'] as List<dynamic>),
        name = json['name'],
        cid = json['cid'];

  static List<Artical> getArticals(List<dynamic> articals) {
    return articals
        .map((artical) => Artical.fromJson(artical as Map<String, dynamic>))
        .toList();
  }
}
