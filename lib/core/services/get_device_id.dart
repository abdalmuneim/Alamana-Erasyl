import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class GetDeviceId {
  static GetDeviceId? _instance;
  // Avoid self instance
  GetDeviceId._();
  static GetDeviceId get instance => _instance ??= GetDeviceId._();

  Future<String?> getDeviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    } else {
      return null;
    }
  }
}
