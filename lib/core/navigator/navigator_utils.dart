import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sanad_abu_yousef/core/fields.dart';
import 'package:sanad_abu_yousef/core/navigator/route_string.dart';
import 'package:sanad_abu_yousef/core/navigator/routes.dart';

class NavigationService {
  static BuildContext get context =>
      Routes.router.routerDelegate.navigatorKey.currentContext!;
}

class NavigatorUtils {
  static BuildContext get _context => NavigationService.context;

  static void goToVideosPlaylist(String id) => _context.pushNamed(
        RouteStrings.videosPlaylist,
        queryParams: <String, String>{
          Fields.videos: id,
        },
      );
}
