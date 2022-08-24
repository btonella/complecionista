// ignore_for_file: unnecessary_null_in_if_null_operators, must_be_immutable

import 'dart:convert';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  int? id;
  String? name;
  String? email;
  String? token;

  User({
    this.id,
    this.name,
    this.email,
    this.token,
  });

  @override
  List<Object> get props => [];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "name": name,
      "email": email,
      "token": token,
    };

    return map;
  }

  static User fromMap(Map<String, dynamic> map) {
    User userModel = User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      token: map['token'],
    );

    return userModel;
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));
}
