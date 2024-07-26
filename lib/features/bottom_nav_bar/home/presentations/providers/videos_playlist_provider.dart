import 'package:alamanaelrasyl/core/services/api_service.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/data/models/video_model.dart';
import 'package:flutter/material.dart';

class VideosPlaylistProvider extends ChangeNotifier {
  List<Video> _videos = [];
  List<Video> get videos => _videos;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadMoreVideos({required String playlistId,String? numLoad}) async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosForPlaylist(playlistId: playlistId,numLoad: numLoad);
    List<Video> allVideos = _videos..addAll(moreVideos);

    _videos = allVideos;
    _isLoading = false;
    notifyListeners();
  }

  disposeList() {
    _videos = [];
  }
}
