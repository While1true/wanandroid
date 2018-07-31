import 'dart:convert' show json;


class TreeBean {

  int errorCode;
  String errorMsg;
  List<Tree> data;


  TreeBean.fromParams({this.errorCode, this.errorMsg, this.data});

  factory TreeBean(jsonStr) => jsonStr is String ? TreeBean.fromJson(json.decode(jsonStr)) : TreeBean.fromJson(jsonStr);

  TreeBean.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = [];

    for (var dataItem in jsonRes['data']){

      data.add(new Tree.fromJson(dataItem));
    }


  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'},"data": $data}';
  }
}



class Tree {

  int courseId;
  int id;
  int order;
  int parentChapterId;
  int visible;
  String name;
  List<ChildTree> children;


  Tree.fromParams({this.courseId, this.id, this.order, this.parentChapterId, this.visible, this.name, this.children});

  Tree.fromJson(jsonRes) {
    courseId = jsonRes['courseId'];
    id = jsonRes['id'];
    order = jsonRes['order'];
    parentChapterId = jsonRes['parentChapterId'];
    visible = jsonRes['visible'];
    name = jsonRes['name'];
    children = [];

    for (var childrenItem in jsonRes['children']){

      children.add(new ChildTree.fromJson(childrenItem));
    }


  }

  @override
  String toString() {
    return '{"courseId": $courseId,"id": $id,"order": $order,"parentChapterId": $parentChapterId,"visible": $visible,"name": ${name != null?'${json.encode(name)}':'null'},"children": $children}';
  }
}



class ChildTree {

  int courseId;
  int id;
  int order;
  int parentChapterId;
  int visible;
  String name;
  List<dynamic> children;


  ChildTree.fromParams({this.courseId, this.id, this.order, this.parentChapterId, this.visible, this.name, this.children});

  ChildTree.fromJson(jsonRes) {
    courseId = jsonRes['courseId'];
    id = jsonRes['id'];
    order = jsonRes['order'];
    parentChapterId = jsonRes['parentChapterId'];
    visible = jsonRes['visible'];
    name = jsonRes['name'];
    children = jsonRes['children'];

  }

  @override
  String toString() {
    return '{"courseId": $courseId,"id": $id,"order": $order,"parentChapterId": $parentChapterId,"visible": $visible,"name": ${name != null?'${json.encode(name)}':'null'},"children": $children}';
  }
}

