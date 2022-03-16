class Story {
  final String id;
  final String url;

  Story(this.id, this.url);

  Story.fromJson(Map<String, dynamic> json, String id)
      : id = id,
        url = json['url'];

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}
