import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:alamanaelrasyl/core/app_const/constant.dart';
import 'package:alamanaelrasyl/core/navigator/navigator_utils.dart';
import 'package:alamanaelrasyl/core/navigator/route_string.dart';
import 'package:alamanaelrasyl/core/services/firebase_collec.dart';
import 'package:alamanaelrasyl/core/services/get_device_id.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

abstract class NotificationService {
  requestPermission();
  Future<String?>? getFCMToken();
  initInfo();
  Future<void> pushNotification({
    required List<String> deviceTokens,
    required String body,
    required String title,
    required Map<String, dynamic> data,
  });
}

class NotificationServiceImpl implements NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  NotificationServiceImpl() {
    requestPermission();
    initInfo();
    getFCMToken();
  }

  @override
  requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      carPlay: false,
      badge: true,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (Platform.isIOS) {
      // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
      final String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        // APNS token is available, make FCM plugin API requests...
        log("getAPNSToken: $apnsToken");
      }
    }

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("User granted provisional permission");
    } else {
      debugPrint("User declined or has not accepted permission");
    }
  }

  @override
  Future<String?>? getFCMToken() async {
    String? token = await _firebaseMessaging.getToken();
    log("FCM TOKEN: ${token ?? "null"}");
    _firebaseMessaging.onTokenRefresh.listen((String fcmToken) {
      token = fcmToken;
      log("REFRESH TOKEN: ${token ?? "null"}");
    }).onError((err) {
      log("FCM ERROR: $err");
    });
    final String? deviceID = await GetDeviceId.instance.getDeviceId();
    if (deviceID != null) {
      log("DEVICE ID: $deviceID");
      FirebaseCollec.instance.fcmTokenCollection(
        deviceID: deviceID,
        data: {
          "deviceId": deviceID,
          "fcmToken": token,
        },
      );
    }
    return token;
  }

  @override
  initInfo() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        try {
          if (details.payload != null) {
            log("payload: ${details.payload!}");
          } else {
            NavigationService.context
                .pushReplacementNamed(RouteStrings.splashPage);
          }
        } catch (e) {
          log("error: ${e.toString()}");
        }
        return;
      },
    );

    /// firebase massaging
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint("--------------- On Messaging: ------------");
      debugPrint(
          "title: ${message.notification!.title} \nbody: ${message.notification?.body} \ndata: ${jsonEncode(message.data)}");

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        contentTitle: message.notification!.title,
        htmlFormatContentTitle: true,
        htmlFormatBigText: true,
        summaryText: message.notification!.body,
        htmlFormatSummaryText: true,
      );
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        'notification',
        'notification',
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        visibility: NotificationVisibility.public,
        playSound: true,
        sound: const RawResourceAndroidNotificationSound('notification'),
        fullScreenIntent: true,
        enableLights: true,
        audioAttributesUsage: AudioAttributesUsage.voiceCommunication,
      );

      NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidNotificationDetails);
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title,
        message.notification!.body,
        platformChannelSpecifics,
        payload: message.data["data"],
      );
    });
  }

  @override
  Future<void> pushNotification({
    required List<String> deviceTokens,
    required String body,
    required String title,
    required Map<String, dynamic> data,
  }) async {
    final List<Future<void>> futures = [];

    for (String token in deviceTokens) {
      futures.add(
        _sendNotification(
          token: token,
          title: title,
          body: body,
          data: data,
        ),
      );
    }

    await Future.wait(futures);
  }

  Future<void> _sendNotification(
      {required String token,
      required String title,
      required String body,
      Map<String, dynamic>? data}) async {
    /// body for post request
    final message = {
      "message": {
        "token": token,
        "notification": {
          "title": title,
          "body": body,
          "image": AppConstant.logo,
        },
        "data": data,
      }
    };
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
    final client =
        await clientViaServiceAccount(await _getAccountCredentials(), scopes);

    const String firebaseUrl =
        'https://fcm.googleapis.com/v1/projects/alamna-el-rasyl/messages:send';
    final response = await http.post(
      Uri.parse(firebaseUrl),
      headers: <String, String>{
        'Authorization': 'Bearer ${client.credentials.accessToken.data}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      debugPrint('Notification sent to token: $token');
    } else {
      debugPrint('Failed to send notification to token: $token');
      debugPrint('Response: ${response.body}');
    }
  }

  Future<dynamic> _loadFileClientData() async {
    final String response = await rootBundle.loadString(
        'assets/alamna-el-rasyl-firebase-adminsdk-csvg9-d9239d88b1.json');
    final data = await json.decode(response);
    final clientModel = ClientModel.fromMap(data);
    return clientModel;
  }

  Future<ServiceAccountCredentials> _getAccountCredentials() async {
    final client = await _loadFileClientData();
    final accountCredentials = ServiceAccountCredentials.fromJson({
      "type": client.type,
      "project_id": client.projectId,
      "private_key_id": client.private_key_id,
      "private_key": client.private_key,
      "client_email": client.client_email,
      "client_id": client.client_id,
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": client.auth_provider_x509_cert_url
    });
    return accountCredentials;
  }
}

class ClientModel {
  final String type;
  final String projectId;
  final String privateKeyId;
  final String privateKey;
  final String clientEmail;
  final String clientId;
  final String authUri;
  final String tokenUri;
  final String authProviderX509CertUrl;
  final String clientX509CertUrl;
  final String universeDomain;
  ClientModel({
    required this.type,
    required this.projectId,
    required this.privateKeyId,
    required this.privateKey,
    required this.clientEmail,
    required this.clientId,
    required this.authUri,
    required this.tokenUri,
    required this.authProviderX509CertUrl,
    required this.clientX509CertUrl,
    required this.universeDomain,
  });

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      type: map['type'] ?? '',
      projectId: map['project_id'] ?? '',
      privateKeyId: map['private_key_id'] ?? '',
      privateKey: map['private_key'] ?? '',
      clientEmail: map['client_email'] ?? '',
      clientId: map['client_id'] ?? '',
      authUri: map['auth_uri'] ?? '',
      tokenUri: map['token_uri'] ?? '',
      authProviderX509CertUrl: map['auth_provider_x509_cert_url'] ?? '',
      clientX509CertUrl: map['client_x509_cert_url'] ?? '',
      universeDomain: map['universe_domain'] ?? '',
    );
  }

  @override
  String toString() {
    return 'ClientModel(type: $type, project_id: $projectId, private_key_id: $privateKeyId, private_key: $privateKey, client_email: $clientEmail, client_id: $clientId, auth_uri: $authUri, token_uri: $tokenUri, auth_provider_x509_cert_url: $authProviderX509CertUrl, client_x509_cert_url: $clientX509CertUrl, universe_domain: $universeDomain)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClientModel &&
        other.type == type &&
        other.projectId == projectId &&
        other.privateKeyId == privateKeyId &&
        other.privateKey == privateKey &&
        other.clientEmail == clientEmail &&
        other.clientId == clientId &&
        other.authUri == authUri &&
        other.tokenUri == tokenUri &&
        other.authProviderX509CertUrl == authProviderX509CertUrl &&
        other.clientX509CertUrl == clientX509CertUrl &&
        other.universeDomain == universeDomain;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        projectId.hashCode ^
        privateKeyId.hashCode ^
        privateKey.hashCode ^
        clientEmail.hashCode ^
        clientId.hashCode ^
        authUri.hashCode ^
        tokenUri.hashCode ^
        authProviderX509CertUrl.hashCode ^
        clientX509CertUrl.hashCode ^
        universeDomain.hashCode;
  }
}
