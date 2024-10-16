// To parse this JSON data, do
//
//     final azkar = azkarFromJson(jsonString);

import 'dart:convert';

import 'package:alamanaelrasyl/features/bottom_nav_bar/tazkiyah_al-nafs/domin/entities/azkar.dart';

List<AzkarModel> azkarFromJson(String str) =>
    List<AzkarModel>.from(json.decode(str).map((x) => AzkarModel.fromJson(x)));

String azkarToJson(List<AzkarModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AzkarModel extends Azkar {
  const AzkarModel({
    super.content,
    super.title,
    super.reference,
    super.info,
    super.timesToRepeat,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (content != null) {
      result.addAll({'content': content});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (reference != null) {
      result.addAll({'reference': reference});
    }
    if (timesToRepeat != null) {
      result.addAll({'timesToRepeat': timesToRepeat});
    }
    if (info != null) {
      result.addAll({'info': info});
    }

    return result;
  }

  factory AzkarModel.fromMap(Map<String, dynamic> map) {
    return AzkarModel(
      content: map['content'],
      title: map['title'],
      info: map['info'],
      reference: map['reference'],
      timesToRepeat: map['timesToRepeat']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AzkarModel.fromJson(String source) =>
      AzkarModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AzkarModel(content: $content, info: $info, title: $title, reference: $reference, timesToRepeat: $timesToRepeat)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AzkarModel &&
        other.content == content &&
        other.title == title &&
        other.info == info &&
        other.reference == reference &&
        other.timesToRepeat == timesToRepeat;
  }

  @override
  int get hashCode {
    return content.hashCode ^
        title.hashCode ^
        reference.hashCode ^
        info.hashCode ^
        timesToRepeat.hashCode;
  }
}
