import 'package:flutter/cupertino.dart';
import 'package:library_manager/service/user_api.dart';

class UserAuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String token = '';
  String user_id = '';
  String email = '';
  String isAdmin = "false";
  String first_name = '';
  String last_name = '';

  void setAuth(value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  bool getAuth() {
    return _isLoggedIn;
  }

  void signIn(String username, String password) async {
    var user = await UserAuthApi().signIn(username, password);
    setAuth(true);
    token = user.token;
    user_id = user.user_id;
    email = user.email;
    isAdmin = user.isAdmin;
    first_name = user.first_name;
    last_name = user.last_name;
    print(getAuth());
    notifyListeners();
  }
}
