// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get main {
    return Intl.message(
      'Home',
      name: 'main',
      desc: '',
      args: [],
    );
  }

  /// `Fatwas`
  String get fatwas {
    return Intl.message(
      'Fatwas',
      name: 'fatwas',
      desc: '',
      args: [],
    );
  }

  /// `Play Lists`
  String get playLists {
    return Intl.message(
      'Play Lists',
      name: 'playLists',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get subscribe {
    return Intl.message(
      'Subscribe',
      name: 'subscribe',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get video {
    return Intl.message(
      'Video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `Slid To Show Videos`
  String get slidToShow {
    return Intl.message(
      'Slid To Show Videos',
      name: 'slidToShow',
      desc: '',
      args: [],
    );
  }

  /// `Operation failed try again`
  String get errorOperation {
    return Intl.message(
      'Operation failed try again',
      name: 'errorOperation',
      desc: '',
      args: [],
    );
  }

  /// `Operation done thank you`
  String get successOperation {
    return Intl.message(
      'Operation done thank you',
      name: 'successOperation',
      desc: '',
      args: [],
    );
  }

  /// `Alamna Alrasol`
  String get alamnaAlrasol {
    return Intl.message(
      'Alamna Alrasol',
      name: 'alamnaAlrasol',
      desc: '',
      args: [],
    );
  }

  /// `Support us`
  String get supportus {
    return Intl.message(
      'Support us',
      name: 'supportus',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `لا يوجد بيانات`
  String get noDataFound {
    return Intl.message(
      'لا يوجد بيانات',
      name: 'noDataFound',
      desc: '',
      args: [],
    );
  }

  /// `لا يوجد فيديوهات`
  String get notHaveVideos {
    return Intl.message(
      'لا يوجد فيديوهات',
      name: 'notHaveVideos',
      desc: '',
      args: [],
    );
  }

  /// `لا يوجد قوائم تشغيل`
  String get notHavePlayLists {
    return Intl.message(
      'لا يوجد قوائم تشغيل',
      name: 'notHavePlayLists',
      desc: '',
      args: [],
    );
  }

  /// `الحقل مطلوب`
  String get fieldRequired {
    return Intl.message(
      'الحقل مطلوب',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `There are no fatwas yet. You can add a fatwa, and we will respond to it as soon as possible.`
  String get noFatwaFound {
    return Intl.message(
      'There are no fatwas yet. You can add a fatwa, and we will respond to it as soon as possible.',
      name: 'noFatwaFound',
      desc: '',
      args: [],
    );
  }

  /// `طلب`
  String get request {
    return Intl.message(
      'طلب',
      name: 'request',
      desc: '',
      args: [],
    );
  }

  /// `إلغاء`
  String get cancel {
    return Intl.message(
      'إلغاء',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `أكتب مسألتك!`
  String get writeYourRequest {
    return Intl.message(
      'أكتب مسألتك!',
      name: 'writeYourRequest',
      desc: '',
      args: [],
    );
  }

  /// `يجب ألا يكون السؤال قل من {word} حرف`
  String ValidatorRequestWordNum(Object word) {
    return Intl.message(
      'يجب ألا يكون السؤال قل من $word حرف',
      name: 'ValidatorRequestWordNum',
      desc: '',
      args: [word],
    );
  }

  /// `Added Successfully and we will replay as soon as!`
  String get addedSuccessfullyAndWeWillReplayAsSoonAs {
    return Intl.message(
      'Added Successfully and we will replay as soon as!',
      name: 'addedSuccessfullyAndWeWillReplayAsSoonAs',
      desc: '',
      args: [],
    );
  }

  /// `SomeThing happened try again later!!`
  String get somethingHappenedTryAgainLater {
    return Intl.message(
      'SomeThing happened try again later!!',
      name: 'somethingHappenedTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `طلب فتوى`
  String get requestFatwa {
    return Intl.message(
      'طلب فتوى',
      name: 'requestFatwa',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
