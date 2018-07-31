class Api{
  static String getHomePageUrl(int page){
    return "http://www.wanandroid.com/article/list/$page/json";
  }
  static const String BANNER="http://www.wanandroid.com/banner/json";

  static const String NAVIGATION="http://www.wanandroid.com/navi/json";
  
  static const String TREE="http://www.wanandroid.com/tree/json";

  static String getTreeArtical(int page,int cid){
    return "http://www.wanandroid.com/article/list/$page/json?cid=$cid";
  }
}