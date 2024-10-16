import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? image;
  final String? id;
  final String? deviceId;
  final String? fcmToken;
  final String? bio;

  final DateTime? createAt;
  final DateTime? updateAt;

  const User({
    this.name,
    this.createAt,
    this.updateAt,
    this.email,
    this.bio,
    this.phone,
    this.address,
    this.image,
    this.id,
    this.deviceId,
    this.fcmToken,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        address,
        image,
        bio,
        createAt,
        updateAt,
        id,
        deviceId,
        fcmToken,
      ];
}
