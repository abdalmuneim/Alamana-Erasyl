import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:alamanaelrasyl/core/utilities/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class WebSiteLaunch {
  static launcher(
    String url,
  ) async {
    if (url.contains('http')) {
      log("is url");
      await launchUrl(Uri.parse(url));
    } else if (RegExp(r'\S+@\S+\.\S+').hasMatch(url)) {
      log("is Email");
      await launchUrl(Uri.parse("mailto:$url"));
    } else if (RegExp(r'^\+971\d{8}$').hasMatch(url)) {
      log("is Phone");
      await launchUrl(Uri.parse("tel:$url"));
    }
  }

  static const String _whatsAppMessage = '';

  static openWhatsApp(
      {required String whatsPhoneNum, String? message = ""}) async {
    // String whatsapp = url!;
    String whatsappURlAndroid =
        "whatsapp://send?phone=$whatsPhoneNum&text=$_whatsAppMessage";
    var whatAppURLIOS =
        "https://wa.me/$whatsPhoneNum?text=${Uri.parse(_whatsAppMessage)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatAppURLIOS))) {
        await launchUrl(Uri.parse(whatAppURLIOS));
      } else {
        Utils.showErrorToast("لم يتم تثبيت تطبيق الواتساب");
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        Utils.showErrorToast("لم يتم تثبيت تطبيق الواتساب");
      }
    }
  }

  static openAppOnStore() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    if (Platform.isAndroid) {
      WebSiteLaunch.launcher(
          "https://play.google.com/store/apps/details?id=$packageName");
    } else if (Platform.isIOS) {
      await _getAppStoreId(packageName).then((value) async {
        final url = 'https://apps.apple.com/app/id$value';
        await WebSiteLaunch.launcher(url);
      }).catchError((onError) {
        Utils.showErrorToast(onError.toString());
      });
    }
  }

  /// for get app id for app on apple store
  static Future<String> _getAppStoreId(String bundleId) async {
    final url = 'https://itunes.apple.com/lookup?bundleId=$bundleId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['results'] != null && json['results'].length > 0) {
        return json['results'][0]['trackId'].toString();
      }
    }
    throw 'App Store ID not found';
  }
}
