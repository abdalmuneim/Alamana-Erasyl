import 'package:alamanaelrasyl/core/navigator/route_string.dart';
import 'package:alamanaelrasyl/core/utilities/fields.dart';
import 'package:alamanaelrasyl/features/about_us/about_view.dart';
import 'package:alamanaelrasyl/features/auth/login/presentation/views/login_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/fatwas/view/fatwas_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/data/models/video_model.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/views/all_videos_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/views/playlist/videos_playlist_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/home/presentations/views/video_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/profile/presentation/views/profile_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/tazkiyah_al-nafs/presentation/views/create_group_view.dart';
import 'package:alamanaelrasyl/features/bottom_nav_bar/tazkiyah_al-nafs/presentation/views/tazkiyah_al_nafs_view.dart';
import 'package:alamanaelrasyl/features/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final GoRouter router = GoRouter(
    routes: <GoRoute>[
      /// splash
      GoRoute(
        name: RouteNameStrings.splashPage,
        path: Paths.splashPage,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashView(),
      ),

      /// bottomNavBar
      GoRoute(
        name: RouteNameStrings.bottomNavBar,
        path: Paths.bottomNavBar,
        builder: (BuildContext context, GoRouterState state) =>
            const BottomNavBarView(),
        routes: [
          /// all videos
          GoRoute(
            name: RouteNameStrings.allVideos,
            path: Paths.allVideos,
            builder: (BuildContext context, GoRouterState state) =>
                const AllVideosView(),
          ),

          /// videos playlist
          GoRoute(
            name: RouteNameStrings.videosPlaylist,
            path: Paths.videosPlaylist,
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
            path: Paths.videoViewer,
            name: RouteNameStrings.videoViewer,
            builder: (context, state) {
              return VideoView(video: Video());
            },
          ),

          /// Fatwas page
          GoRoute(
            path: Paths.fatwas,
            name: RouteNameStrings.fatwas,
            builder: (BuildContext context, GoRouterState state) =>
                const FatwasView(),
          ),

          /// profile
          GoRoute(
            name: RouteNameStrings.profile,
            path: Paths.profile,
            builder: (BuildContext context, GoRouterState state) =>
                const ProfileView(),
          ),
        ],
      ),

      /// about us
      GoRoute(
        name: RouteNameStrings.aboutUs,
        path: Paths.aboutUs,
        builder: (BuildContext context, GoRouterState state) =>
            const AboutUsView(),
      ),

      /// tazkiyah al nafs
      GoRoute(
          name: RouteNameStrings.tazkiyahAlNafs,
          path: Paths.tazkiyahAlNafs,
          builder: (BuildContext context, GoRouterState state) =>
              const TazkiyahAlNafsView(),
          routes: [
            /// create group page
            GoRoute(
              path: Paths.createGroup,
              name: RouteNameStrings.createGroup,
              builder: (BuildContext context, GoRouterState state) =>
                  const CreateGroupView(),
            ),
          ]),

      /// login
      GoRoute(
          name: RouteNameStrings.login,
          path: Paths.login,
          builder: (BuildContext context, GoRouterState state) =>
              const LoginView()),
    ],
  );
}
