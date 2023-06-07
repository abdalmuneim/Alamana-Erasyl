import 'dart:convert';

Video videoFromMap(String str) => Video.fromMap(json.decode(str));

String videoToMap(Video data) => json.encode(data.toMap());

class Video {
  final String? id;
  final String? title;
  final String? description;
  final String? thumbnailUrl;
  final String? channelTitle;

  Video({
    this.id,
    this.title,
    this.description,
    this.thumbnailUrl,
    this.channelTitle,
  });

  factory Video.fromMap(Map<String, dynamic> snippet) {
    return Video(
      id: snippet['resourceId']['videoId'],
      title: snippet['title'],
      description: snippet['resourceId']['description'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
      channelTitle: snippet['channelTitle'],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "thumbnailUrl": thumbnailUrl,
        "channelTitle": channelTitle,
      };
}
