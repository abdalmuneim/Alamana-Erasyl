import 'dart:convert';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? image;
  final String? id;
  final String? deviceId;
  final String? fcmToken;

  User({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.image,
    this.id,
    this.deviceId,
    this.fcmToken,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        image: json["image"],
        id: json["id"],
        deviceId: json["deviceId"],
        fcmToken: json["fcmToken"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    if (name != null) {
      data['name'] = name;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (phone != null) {
      data['phone'] = phone;
    }
    if (address != null) {
      data['address'] = address;
    }
    if (image != null) {
      data['image'] = image;
    }
    if (id != null) {
      data['id'] = id;
    }
    if (deviceId != null) {
      data['deviceId'] = deviceId;
    }
    if (fcmToken != null) {
      data['fcmToken'] = fcmToken;
    }
    return data;
  }
}
