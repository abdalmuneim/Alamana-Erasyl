import 'dart:convert';

import 'package:alamanaelrasyl/features/bottom_nav_bar/fatwas/domin/entities/fatwa.dart';

class FatwaModel extends Fatwa {
  const FatwaModel({
    super.id,
    super.reactCount,
    super.fatwaDescription,
    super.deviceID,
    super.shareCount,
    super.reply,
    super.createAt,
    super.userImg,
    super.repliedImg,
    super.replyAt,
    super.repliedName,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (shareCount != null) {
      result.addAll({'shareCount': id});
    }
    if (repliedName != null) {
      result.addAll({'repliedName': id});
    }
    if (reactCount != null) {
      result.addAll({'reactCount': reactCount});
    }
    if (deviceID != null) {
      result.addAll({'deviceID': deviceID});
    }
    if (fatwaDescription != null) {
      result.addAll({'fatwaDescription': fatwaDescription});
    }
    if (reply != null) {
      result.addAll({'reply': reply});
    }
    if (createAt != null) {
      result.addAll({'createAt': createAt});
    }
    if (userImg != null) {
      result.addAll({'userImg': userImg});
    }
    if (repliedImg != null) {
      result.addAll({'repliedImg': repliedImg});
    }
    if (replyAt != null) {
      result.addAll({'replyAt': replyAt});
    }

    return result;
  }

  factory FatwaModel.fromMap(Map<String, dynamic> map) {
    return FatwaModel(
      id: map['id']?.toInt(),
      shareCount: map['shareCount']?.toInt(),
      reactCount: map['reactCount']?.toInt(),
      deviceID: map['deviceID'],
      repliedName: map['repliedName'],
      fatwaDescription: map['fatwaDescription'],
      reply: map['reply'],
      createAt: map['createAt'],
      userImg: map['userImg'],
      repliedImg: map['repliedImg'],
      replyAt: map['replyAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FatwaModel.fromJson(String source) =>
      FatwaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FatwaModel(id: $id, reactCount: $reactCount, shareCount: $shareCount, deviceID: $deviceID, fatwaDescription: $fatwaDescription, reply: $reply, createAt: $createAt, userImg: $userImg, replyImg: $repliedImg, replyAt: $replyAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FatwaModel &&
        other.id == id &&
        other.reactCount == reactCount &&
        other.repliedName == repliedName &&
        other.deviceID == deviceID &&
        other.shareCount == shareCount &&
        other.fatwaDescription == fatwaDescription &&
        other.reply == reply &&
        other.createAt == createAt &&
        other.userImg == userImg &&
        other.repliedImg == repliedImg &&
        other.replyAt == replyAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        reactCount.hashCode ^
        deviceID.hashCode ^
        fatwaDescription.hashCode ^
        reply.hashCode ^
        createAt.hashCode ^
        userImg.hashCode ^
        repliedImg.hashCode ^
        replyAt.hashCode;
  }
}
