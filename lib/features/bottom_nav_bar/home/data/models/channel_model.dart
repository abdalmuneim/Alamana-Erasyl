import 'package:alamanaelrasyl/features/bottom_nav_bar/home/data/models/video_model.dart';

class Channel {
  final String? id;
  final String? title;
  final String? profilePictureUrl;
  final String? subscriberCount;
  final String? description;
  final String? videoCount;
  final String? uploadPlaylistId;
  List<Video>? videos;

  Channel({
    this.id,
    this.title,
    this.profilePictureUrl,
    this.subscriberCount,
    this.description,
    this.videoCount,
    this.uploadPlaylistId,
    this.videos,
  });

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
      id: map['id'],
      title: map['snippet']['title'],
      description: map['snippet']['description'],
      profilePictureUrl: map['snippet']['thumbnails']['default']['url'],
      subscriberCount: map['statistics']['subscriberCount'],
      videoCount: map['statistics']['videoCount'],
      uploadPlaylistId: map['contentDetails']['relatedPlaylists']['uploads'],
    );
  }
}
