import 'package:flutter/material.dart';
import 'package:sanad_abu_yousef/models/channel_model.dart';
import 'package:sanad_abu_yousef/models/video_model.dart';
import 'package:sanad_abu_yousef/services/api_service.dart';

class AllVideosProvider extends ChangeNotifier {
  Channel? _channel;
  Channel? get channel => _channel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  initChannel() async {
    Channel channel = await APIService.instance.fetchChannel();
    _channel = channel;
    notifyListeners();
  }

  loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel!.uploadPlaylistId ?? "");
    List<Video> allVideos = _channel!.videos!..addAll(moreVideos);

    _channel!.videos = allVideos;
    notifyListeners();
    _isLoading = false;
  }
}
