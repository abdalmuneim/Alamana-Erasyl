import 'package:flutter/material.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/data/models/video_model.dart';
import 'package:alamanaelrasyl/core/services/api_service.dart';

class VideosPlaylistProvider extends ChangeNotifier {
  List<Video>? _videos = [];
  List<Video>? get videos => _videos;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadMoreVideos({required String playlistId}) async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosForPlaylist(playlistId: playlistId);
    List<Video> allVideos = _videos!..addAll(moreVideos);

    _videos = allVideos;
    notifyListeners();
    _isLoading = false;
  }

  disposeList() {
    _videos = [];
  }
}
