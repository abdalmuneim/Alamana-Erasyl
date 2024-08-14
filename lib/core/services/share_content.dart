import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as print;
import 'package:alamanaelrasyl/core/utilities/utilities.dart';
import 'package:alamanaelrasyl/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:html/parser.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/src/types/interface.dart';

class ShareWidget {
  static ShareWidget? _instance;
  // Avoid self instance
  ShareWidget._();
  static ShareWidget get instance => _instance ??= ShareWidget._();

  doShare({
    required BuildContext context,
    required Map<String, dynamic> data,
    required ValueChanged<bool> onchange,
    ValueChanged<ShareResult>? onResult,
  }) async {
    print.log(jsonEncode(data));
    onchange(true);

    await _urlToFile(
        imageUrl: data['img'] ??
            data['header_image_path'] ??
            data['image_path'] ??
            data["image"] ??
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEkA9gblpiJEJfpBwChxch8UVTI4VkPKpkSA&s")
        .then((File file) async {
      final isDone = await Share.shareXFiles(
        [XFile(file.path)],
        text: ((data['date']) ?? " ") +
            "\n\n" +
            ((data['title']) ?? " ") +
            "\n\n" +
            ((data['name']) ?? " ") +
            "\n\n" +
            ((data['userName']) ?? " ") +
            "\n\n" +
            ((data['description']) ?? " ") +
            "\n\n" +
            _parseHtmlString(
              data['content'] ?? "No content",
              //    '<iframe width="560" height="315" src="https://www.youtube.com/embed/D_mCZlQZg9Y" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>',
            ),
      );
      onResult?.call(isDone);
    }).catchError((e) {
      Utils.showErrorToast( S.of(context).somThingHappened(e.toString()));
    });

    onchange(false);
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  Future<File> _urlToFile({required String imageUrl}) async {
    var rng = new Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
    http.Response response = await http.get(
      Uri.parse(imageUrl),
    );
    await file.writeAsBytes(response.bodyBytes);

    return file;
  }
}