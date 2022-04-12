import 'dart:async';

import 'package:streamsubscription/user/user.dart';

class UserManager {
  List<User> users = [];

  final streamController = StreamController<List<User>>.broadcast();
  late final StreamSubscription streamSubscription;

  User user = User();

  void insert(String name, String city){
    User user = User();
    user.name = name;
    user.city = city;

    users.add(user);

    streamController.sink.add(users);
  }
}
