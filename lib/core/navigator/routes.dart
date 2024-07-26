import 'package:alamanaelrasyl/core/navigator/route_string.dart';
import 'package:alamanaelrasyl/core/utilities/fields.dart';
import 'package:alamanaelrasyl/features/about_us/about_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/fatwas/view/fatwas_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/data/models/video_model.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/views/all_videos_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/views/playlist/videos_playlist_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/views/video_view.dart';
import 'package:alamanaelrasyl/features/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final GoRouter router = GoRouter(
    routes: <GoRoute>[
      /// splash
      GoRoute(
        name: RouteStrings.splashPage,
        path: RouteStrings.splashPage,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashView(),
      ),

      /// bottomNavBar
      GoRoute(
        name: RouteStrings.bottomNavBar,
        path: RouteStrings.bottomNavBar,
        builder: (BuildContext context, GoRouterState state) =>
            const BottomNavBarView(),
        routes: [
          /// all videos
          GoRoute(
            name: RouteStrings.allVideos,
            path: RouteStrings.allVideos,
            builder: (BuildContext context, GoRouterState state) =>
                const AllVideosView(),
          ),

          /// videos playlist
          GoRoute(
            name: RouteStrings.videosPlaylist,
            path: RouteStrings.videosPlaylist,
            builder: (BuildContext context, GoRouterState state) {
              final String id = state.queryParameters[Fields.id]!;
              final String title = state.queryParameters[Fields.title]!;
              final String description =
                  state.queryParameters[Fields.description]!;
              final String url = state.queryParameters[Fields.url]!;
              final String itemCount = state.queryParameters[Fields.itemCount]!;
              return VideosPlaylistView(
                id: id,
                title: title,
                description: description,
                url: url,
                itemCount: itemCount,
              );
            },
          ),

          /// video viewer
          GoRoute(
            path: RouteStrings.videoViewer,
            name: RouteStrings.videoViewer,
            builder: (context, state) {
              return VideoView(video: Video());
            },
          ),

          /// Fatwas page
          GoRoute(
            path: RouteStrings.fatwas,
            name: RouteStrings.fatwas,
            builder: (BuildContext context, GoRouterState state) =>
                const FatwasView(),
          ),
        ],
      ),

      /// about us
      GoRoute(
        name: RouteStrings.aboutUs,
        path: RouteStrings.aboutUs,
        builder: (BuildContext context, GoRouterState state) =>
            const AboutUsView(),
      )
    ],
  );
}
