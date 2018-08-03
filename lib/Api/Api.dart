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
  static const String LOGIN="http://www.wanandroid.com/user/login";

  static const String REGIDTER="http://www.wanandroid.com/user/register";


  static String getUncollectUrl(int id){
    return "http://www.wanandroid.com/lg/uncollect_originId/$id/json";
  }

  /**
   * 我的收藏页
   */
  static String getUncollectContainSelfUrl(int id){
    return "http://www.wanandroid.com/lg/uncollect/$id/json";
  }
  static String getCollectUrl(int id){
    return "http://www.wanandroid.com/lg/collect/$id/json";
  }
}