class HomeModel {
  String? title;
  String? link;
  String? description;
  String? imageUrl;
  String? sourceName;
  String? sourceIcon;
  List? country;
  List? category;
  String? pubDate;
  String? language;
  final String nextPageId;

  HomeModel(this.nextPageId,
      {this.title,
      this.link,
      this.description,
      this.imageUrl,
      this.sourceIcon,
      this.sourceName,
      this.country,
      this.category,
      this.language,
      this.pubDate});

  HomeModel.fromJson(Map<String, dynamic> json, this.nextPageId) {
    title = json['title'];
    link = json['link'];
    description = json['description'];
    pubDate = json['pubDate'];
    imageUrl = json['image_url'];
    sourceName = json['source_name'];
    sourceIcon = json['source_icon'];
    language = json['language'];
    country = json['country'];
    category = json['category'];
  }
}
