// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    this.message,
    this.data,
  });

  String message;
  List<User> data;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    message: json["message"],
    data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class User {
  User({
    this.id,
    this.username,
    this.publicKey,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String username;
  String publicKey;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    username: json["username"],
    publicKey: json["publicKey"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "publicKey": publicKey,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
