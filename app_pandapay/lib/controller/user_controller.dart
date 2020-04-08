import 'package:app_pandapay/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class UserController {
  var host = 'http://192.168.0.11:8080/user';
  Dio dio = new Dio();
  Response response;
  SharedPreferences prefs;

  Future<bool> isUser(String cpf) async {
    try {
      response = await dio.get(host + '/user_cpf/${cpf}');
      return response.data['message'];
    } catch (e) {
      print(e);
    }
  }

  Future<bool> login(User user) async {
    try {
      response = await dio.post(host + '/login',
          data: {"cpf": user.cpf, "password": user.password});

      if (response.data['message'] == null) {
        User user = User.fromJson(response.data);
        auth(user.id);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> create(User user) async {
    try {
      response = await dio.post(
        host + '/signup',
        data: user.toJson(),
      );
      if (response.data['message'] == null) {
        auth(response.data['id']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.data);
    }
  }

  Future auth(int id) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('idUser', id);
    prefs.setBool('isAuth', true);
  }

  Future<bool> isAuth() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAuth');
  }

  Future<String> getBalance() async {
    prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('idUser');    try {
      response = await dio.get(host + '/get_balance/${id}');

      if (response.data != null) {
        return response.data['balance'];
      } else {
        print(response.data);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<User> getUser() async {
    prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('idUser');
    try {
      response = await dio.get(host + '/${id}');
      if (response.data != null) {
        User user = User.fromJson(response.data);

        return user;
      } else {
        print(response.data);
      }
    } catch (e) {
      print(e.data);
    }
  }
}
