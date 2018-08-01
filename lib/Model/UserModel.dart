import 'dart:convert' show json;

class UserModel {
  int errorCode;
  String errorMsg;
  User data;

  UserModel.fromParams({this.errorCode, this.errorMsg, this.data});

  factory UserModel(jsonStr) => jsonStr is String
      ? UserModel.fromJson(json.decode(jsonStr))
      : UserModel.fromJson(jsonStr);

  UserModel.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    if (errorCode >= 0) data = new User.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null ? '${json
        .encode(errorMsg)}' : 'null'},"data": $data}';
  }
}

class User {
  int id;
  int type;
  String email;
  String icon;
  String password;
  String username;
  List<int> collectIds;

  User.fromParams(
      {this.id,
      this.type,
      this.email,
      this.icon,
      this.password,
      this.username,
      this.collectIds});

  User.fromJson(jsonRes) {
    id = jsonRes['id'];
    type = jsonRes['type'];
    email = jsonRes['email'];
    icon = jsonRes['icon'];
    password = jsonRes['password'];
    username = jsonRes['username'];
    collectIds =
        (jsonRes['collectIds'] as List<dynamic>).map((d) => d as int).toList();
  }

  @override
  String toString() {
    return '{"id": $id,"type": $type,"email": ${email != null ? '${json.encode(
        email)}' : 'null'},"icon": ${icon != null
        ? '${json.encode(icon)}'
        : 'null'},"password": ${password != null
        ? '${json.encode(password)}'
        : 'null'},"username": ${username != null
        ? '${json.encode(username)}'
        : 'null'},"collectIds": $collectIds}';
  }
}
