import 'package:equatable/equatable.dart';

class Fatwa extends Equatable {
  final int? id;
  final int? reactCount;
  final int? shareCount;
  final String? deviceID;
  final String? fatwaDescription;
  final String? reply;
  final String? createAt;
  final String? userImg;
  final String? replyImg;
  final String? replyAt;
  const Fatwa({
    this.id,
    this.reactCount,
    this.deviceID,
    this.fatwaDescription,
    this.reply,
    this.createAt,
    this.userImg,
    this.replyAt,
    this.replyImg,
    this.shareCount,
  });

  @override
  List<Object?> get props => [
        id,
        deviceID,
        reactCount,
        shareCount,
        fatwaDescription,
        reply,
        createAt,
        userImg,
        replyImg,
        replyAt,
      ];
}
