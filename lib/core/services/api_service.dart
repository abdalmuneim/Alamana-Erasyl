import 'dart:convert';
import 'dart:io';
import 'package:alamanaerasyl/core/app_const/api_key.dart';
import 'package:alamanaerasyl/core/app_const/constant.dart';
import 'package:http/http.dart' as http;
import 'package:alamanaerasyl/features/bottom_nav_bar/home/data/models/channel_model.dart';
import 'package:alamanaerasyl/features/bottom_nav_bar/home/data/models/error_model.dart';
import 'package:alamanaerasyl/features/bottom_nav_bar/home/data/models/playlist_model.dart';
import 'package:alamanaerasyl/features/bottom_nav_bar/home/data/models/video_model.dart';
import 'package:alamanaerasyl/core/services/socet.dart';

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
    try {
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
    } on SocketException {
      return ServerService<List<ItemPlaylist>>()
          .timeOutMethod(() => fetchPlaylistsFromChannel());
    } catch (e) {
      rethrow;
    }
  }

  /// fetchVideosFromPlaylist
  Future<List<Video>> fetchVideosFromPlaylist(
      {required String playlistId}) async {
    try {
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
        for (var json in videosJson) {
          videos.add(
            Video.fromMap(json['snippet']),
          );
        }
        return videos;
      } else {
        throw json.decode(response.body)['error']['message'];
      }
    } on SocketException {
      return ServerService<List<Video>>()
          .timeOutMethod(() => fetchVideosFromPlaylist(
                playlistId: playlistId,
              ));
    } catch (e) {
      rethrow;
    }
  }

  /// fetchVideosFromPlaylist
  Future<List<Video>> fetchVideosForPlaylist(
      {required String playlistId}) async {
    try {
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
        for (var json in videosJson) {
          videos.add(
            Video.fromMap(json['snippet']),
          );
        }
        return videos;
      } else {
        throw json.decode(response.body)['error']['message'];
      }
    } on SocketException {
      return ServerService<List<Video>>()
          .timeOutMethod(() => fetchVideosForPlaylist(
                playlistId: playlistId,
              ));
    } catch (e) {
      rethrow;
    }
  }
}
