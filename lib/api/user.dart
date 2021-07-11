import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quick_car/constants/strings.dart';
import 'package:quick_car/data_class/user_signup.dart';
import '../data_class/user_signin.dart';

class UserApi {
  Future<UserSignIn> login(UserSignIn usi) {}
}


class QuickCarUserApi implements UserApi {
  Future<UserSignIn> login(UserSignIn usi) async {
    Map body = {'username': usi.email, 'password': usi.password };
    var res = await http.post(Uri.parse(Strings.QUICKCAR_URL +"users/login/"), body: body);
    Map map = json.decode(res.body) as Map<String, dynamic>;
    UserSignIn user = UserSignIn.fromJson(map);
    if (res.statusCode == 200) {
      print("login successful");
      var tokenResponse = await http.post(Uri.parse(Strings.QUICKCAR_URL +"api-token-auth/"), body: body);
      var map = jsonDecode(tokenResponse.body);
      user.token = map['token'];

      var userProfileResponse = await http.get(Uri.
        parse(Strings.QUICKCAR_URL + "users/usersprofiles/" + user.id.toString()));
      if (userProfileResponse.statusCode == 200) {
        print("got user profile");
        map = jsonDecode(userProfileResponse.body);
        user.setDetailsFromUserProfile(map);
      }
      return user;
    } else {
      // TODO: do the reasons of fail
      throw 'Login failed';
    }

  }
}