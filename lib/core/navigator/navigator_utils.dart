import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:alamanaelrasyl/core/utilities/fields.dart';
import 'package:alamanaelrasyl/core/navigator/route_string.dart';
import 'package:alamanaelrasyl/core/navigator/routes.dart';

class NavigationService {
  static BuildContext get context =>
      Routes.router.routerDelegate.navigatorKey.currentContext!;
}

class NavigatorUtils {
  static BuildContext get _context => NavigationService.context;

  static void goToVideosPlaylist(String id) => _context.pushNamed(
        RouteStrings.videosPlaylist,
        queryParameters: <String, String>{
          Fields.videos: id,
        },
      );
}
