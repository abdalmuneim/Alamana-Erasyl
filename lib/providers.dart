import 'package:alamanaelrasyl/features/auth/login/presentation/providers/login_provider.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/bottom_nav_bar_provider.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/fatwas/provider/fatwas_provider.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/providers/all_videos_provider.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/providers/playlists_provider.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/providers/tabs_provider.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/providers/video_provider.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/providers/videos_playlist_provider.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/profile/presentation/providers/profile_provider.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/tazkiyah_al-nafs/presentation/providers/tazkiyah_al_nafs_provider.dart';
import 'package:alamanaelrasyl/features/splash/splash_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  static List<SingleChildWidget> providers = [
    /// auth provider
    ChangeNotifierProvider(create: (_) => LoginProvider()),

    /// bottom nav bar provider
    ChangeNotifierProvider(create: (_) => BottomNavBarProvider()),

    /// tazkiyah al nafs provider
    ChangeNotifierProvider(create: (_) => TazkiyahAlNafsProvider()),

    /// profile provider
    ChangeNotifierProvider(create: (_) => ProfileProvider()),

    /// all videos from playlist provider
    ChangeNotifierProvider(create: (_) => AllVideosProvider()),

    /// playlist provider
    ChangeNotifierProvider(create: (_) => PlaylistsProvider()),

    /// splash provider
    ChangeNotifierProvider(create: (_) => SplashProvider()),

    /// tabs provider
    ChangeNotifierProvider(create: (_) => TabsProvider()),

    /// video Provider
    ChangeNotifierProvider(create: (_) => VideoProvider()),

    /// Videos Playlist Provider
    ChangeNotifierProvider(create: (_) => VideosPlaylistProvider()),

    /// Fatwa Provider
    ChangeNotifierProvider(create: (_) => FatwasProvider()),
  ];
}
