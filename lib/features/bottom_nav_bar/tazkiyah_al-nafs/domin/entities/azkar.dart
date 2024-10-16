import 'package:equatable/equatable.dart';

class Azkar extends Equatable {
  final String? content;
  final String? title;
  final String? reference;
  final String? info;
  final int? timesToRepeat;
  const Azkar({
    this.content,
    this.info,
    this.title,
    this.reference,
    this.timesToRepeat,
  });

  @override
  List<Object?> get props => [
        content,
        title,
        reference,
        info,
        timesToRepeat,
      ];
}
