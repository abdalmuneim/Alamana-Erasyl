import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? image;
  final int? id;
  final String? deviceId;
  final String? fcmToken;

  const User({
    this.name,
    this.email,
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
        id,
        deviceId,
        fcmToken,
      ];
}
