import 'dart:async';

class User {

  String? _name;
  String? _city;

  User({String? name, String? city}) {
    _name = name;
    _city = city;
  }

  User.fromJson(dynamic userData) {
    _name = userData['name'] as String;
    _city = userData['city'] as String;
  }

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }

  String? get city => _city;

  set city(String? value) {
    _city = value;
  }

}