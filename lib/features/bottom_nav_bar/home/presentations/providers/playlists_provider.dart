import 'package:flutter/material.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/data/models/playlist_model.dart';
import 'package:alamanaelrasyl/core/services/api_service.dart';

class PlaylistsProvider extends ChangeNotifier {
  late List<ItemPlaylist>? _playlist;
  List<ItemPlaylist>? get playlists => _playlist;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  initPlaylist() async {
    _isLoading = true;

    final List<ItemPlaylist> playlist =
        await APIService.instance.fetchPlaylistsFromChannel();
    _playlist = playlist;
    _isLoading = false;
    notifyListeners();
  }
}
