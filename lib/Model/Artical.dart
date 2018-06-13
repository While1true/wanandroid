class Artical {
  final String apkLink;
  final String author;
  final int chapterId;
  final String chapterName;
   bool collect;
  final int courseId;
  final String desc;
  final bool fresh;
  final int id;
  final int type;
  final int userId;
  final int visible;
  final int zan;
  final String link;
  final String niceDate;
  final String origin;
  final String projectLink;
  final int publishTime;
  final int superChapterId;
  final String superChapterName;
  final String title;
  final String envelopePic;
  final List<Tag> tags;

  Artical({this.apkLink, this.author, this.chapterId,
    this.chapterName, this.collect, this.courseId, this.desc, this.fresh,
    this.id, this.type, this.userId, this.visible, this.zan, this.link, this.niceDate, this.origin,
    this.projectLink, this.publishTime, this.superChapterId
    , this.superChapterName, this.title,this.envelopePic, this.tags});

  Artical.fromJson(Map<String, dynamic> json)
      :
        apkLink=json['apkLink'],
        author=json['author'],
        chapterId=json['chapterId'],
        chapterName=json['chapterName'],
        collect=json['collect'],
        courseId=json['courseId'],
        desc=json['desc'],
        fresh=json['fresh'],
        envelopePic=json['envelopePic'],
        id=json['id'],
        type=json['type'],
        userId=json['userId'],
        visible=json['visible'],
        zan=json['zan'],
        link=json['link'],
        niceDate=json['niceDate'],
        origin=json['origin'],
        projectLink=json['projectLink'],
        publishTime=json['publishTime'],
        superChapterId=json['superChapterId'],
        superChapterName=json['superChapterName'],
        title=json['title'],
        tags=getTag(json['tags']);

  static List<Tag> getTag(List<dynamic> tags) {
    return tags.map((tag) => Tag((tag as Map<String, dynamic>)['name'], (tag as Map<String, dynamic>)['url'])).toList();
  }
}

class Tag {
  final String name;
  final String url;

  Tag(this.name, this.url);

  Tag.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];
}