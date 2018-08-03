
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class CookieUtil{
  static Future<Map<String,String>> getCookie()async{
    Map<String,String> headers={};
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String cookie=sharedPreferences.getString("cookie");
    if(cookie!=null&&cookie.isNotEmpty){
      headers["Cookie"]=cookie;
    }
    return headers;
  }
}