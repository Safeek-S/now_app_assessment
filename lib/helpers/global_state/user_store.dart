import 'package:mobx/mobx.dart';

import '../../models/user_model.dart';
part 'user_store.g.dart';
class UserStore extends _UserStore with _$UserStore{}
abstract class _UserStore with Store {
  

  @observable
  User? user;

  @action
  void setUser(User user) {
    this.user = user;
  }
}

class UserSingleton {
  static final UserSingleton _instance = UserSingleton._();

  static UserSingleton get instance => _instance;

  final UserStore _store = UserStore();

  UserSingleton._();

  UserStore get store => _store;
}
