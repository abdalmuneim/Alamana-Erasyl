import 'dart:convert';
import 'dart:io';
import 'package:sanad_abu_yousef/core/api_key.dart';
import 'package:sanad_abu_yousef/core/constant.dart';
import 'package:http/http.dart' as http;
import 'package:sanad_abu_yousef/models/channel_model.dart';
import 'package:sanad_abu_yousef/models/error_model.dart';
import 'package:sanad_abu_yousef/models/playlist_model.dart';
import 'package:sanad_abu_yousef/models/video_model.dart';

class APIService {
  APIService._instantiate();
  APIService();

  static final APIService instance = APIService._instantiate();
  String _nextPageToken = '';

  /// Fetch channel
  Future<Channel> fetchChannel() async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': Constant.channelId,
      'key': APIKeys.youtubeAPI,
    };
    Uri uri = Uri.https(
      Constant.basicApi,
      '/youtube/v3/channels',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Channel
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      // Fetch first batch of videos from uploads playlist
      channel.videos = await fetchVideosFromPlaylist(
        playlistId: channel.uploadPlaylistId ?? "",
      );
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  /// fetch Playlists From Channel
  Future<List<ItemPlaylist>> fetchPlaylistsFromChannel() async {
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails',
      'channelId': Constant.channelId,
      'maxResults': '18',
      'key': APIKeys.youtubeAPI,
    };
    Uri uri = Uri.https(
      Constant.basicApi,
      '/youtube/v3/playlists',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get playlist
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      PlaylistModel playlist = playlistFromMap(response.body);

      return playlist.items ?? [];
    } else {
      throw errorModelFromMap(response.body);
    }
  }

  /// fetchVideosFromPlaylist
  Future<List<Video>> fetchVideosFromPlaylist(
      {required String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': APIKeys.youtubeAPI,
    };
    Uri uri = Uri.https(
      Constant.basicApi,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromMap(json['snippet']),
        ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  /// fetchVideosFromPlaylist
  Future<List<Video>> fetchVideosForPlaylist(
      {required String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': APIKeys.youtubeAPI,
    };
    Uri uri = Uri.https(
      Constant.basicApi,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromMap(json['snippet']),
        ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
