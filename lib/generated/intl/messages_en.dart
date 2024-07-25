// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(word) => "يجب ألا يكون السؤال قل من ${word} حرف";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "ValidatorRequestWordNum": m0,
        "aboutUs": MessageLookupByLibrary.simpleMessage("About Us"),
        "alamnaAlrasol": MessageLookupByLibrary.simpleMessage("Alamna Alrasol"),
        "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
        "errorOperation":
            MessageLookupByLibrary.simpleMessage("Operation failed try again"),
        "fatwas": MessageLookupByLibrary.simpleMessage("Fatwas"),
        "fieldRequired": MessageLookupByLibrary.simpleMessage("الحقل مطلوب"),
        "main": MessageLookupByLibrary.simpleMessage("Home"),
        "noDataFound": MessageLookupByLibrary.simpleMessage("لا يوجد بيانات"),
        "noFatwaFound": MessageLookupByLibrary.simpleMessage(
            "There are no fatwas yet. You can add a fatwa, and we will respond to it as soon as possible."),
        "notHavePlayLists":
            MessageLookupByLibrary.simpleMessage("لا يوجد قوائم تشغيل"),
        "notHaveVideos":
            MessageLookupByLibrary.simpleMessage("لا يوجد فيديوهات"),
        "playLists": MessageLookupByLibrary.simpleMessage("Play Lists"),
        "request": MessageLookupByLibrary.simpleMessage("طلب"),
        "slidToShow":
            MessageLookupByLibrary.simpleMessage("Slid To Show Videos"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Subscribe"),
        "successOperation":
            MessageLookupByLibrary.simpleMessage("Operation done thank you"),
        "supportus": MessageLookupByLibrary.simpleMessage("Support us"),
        "video": MessageLookupByLibrary.simpleMessage("Video"),
        "writeYourReqest": MessageLookupByLibrary.simpleMessage("أكتب مسألتك!")
      };
}
