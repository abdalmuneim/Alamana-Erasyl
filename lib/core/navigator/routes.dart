import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sanad_abu_yousef/core/fields.dart';
import 'package:sanad_abu_yousef/core/navigator/route_string.dart';
import 'package:sanad_abu_yousef/presentations/view/about_view.dart';
import 'package:sanad_abu_yousef/presentations/view/playlist/videos_playlist_view.dart';
import 'package:sanad_abu_yousef/presentations/view/splash_view.dart';
import 'package:sanad_abu_yousef/presentations/view/tabs_view.dart';

class Routes {
  static final GoRouter router = GoRouter(
    routes: <GoRoute>[
      /// splash
      GoRoute(
        name: RouteStrings.splashPage,
        path: RouteStrings.splashPage,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
      ),

      /// tabs
      GoRoute(
        name: RouteStrings.tabs,
        path: RouteStrings.tabs,
        builder: (BuildContext context, GoRouterState state) {
          return const TabsView();
        },
      ),

      /// videos playlist
      GoRoute(
        name: RouteStrings.videosPlaylist,
        path: RouteStrings.videosPlaylist,
        builder: (BuildContext context, GoRouterState state) {
          final String id = state.queryParams[Fields.id]!;
          final String title = state.queryParams[Fields.title]!;
          final String description = state.queryParams[Fields.description]!;
          final String url = state.queryParams[Fields.url]!;
          final String itemCount = state.queryParams[Fields.itemCount]!;
          return VideosPlaylistView(
            id: id,
            title: title,
            description: description,
            url: url,
            itemCount: itemCount,
          );
        },
      ),

      /// videos playlist
      GoRoute(
        name: RouteStrings.about,
        path: RouteStrings.about,
        builder: (BuildContext context, GoRouterState state) {
          return AboutView();
        },
      ),
    ],
  );
}
