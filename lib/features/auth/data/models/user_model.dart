import 'dart:convert';

import 'package:alamanaelrasyl/features/auth/domin/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userFromMap(String str) => UserModel.fromMap(json.decode(str));

String userToMap(UserModel data) => json.encode(data.toMap());

class UserModel extends User{


  UserModel({
    super.name,
    super.email,
    super.phone,
    super.address,
    super.image,
    super.id,
    super.deviceId,
    super.fcmToken,
    super.createAt,
    super.updateAt,
    super.bio,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        bio: json["bio"],
        createAt: json['createdAt'] != null
            ? (json['createdAt'] as Timestamp).toDate()
            : null,
        updateAt: json['updatedAt'] != null
            ? (json['updatedAt'] as Timestamp).toDate()
            : null,
        phone: json["phone"],
        email: json["email"],
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
    if (createAt != null) {
      data['createAt'] = Timestamp.fromDate(createAt!);
    } else {
      data['createAt'] = FieldValue.serverTimestamp();
    }
    if (updateAt != null) {
      data['updateAt'] = Timestamp.fromDate(updateAt!);
    }else{
      data['updateAt'] = FieldValue.serverTimestamp();

    }
    return data;
  }
}
