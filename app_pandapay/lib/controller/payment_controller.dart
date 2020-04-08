import 'package:app_pandapay/model/payment.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentController {
  var host = 'http://192.168.0.11:8080/payment/';
  Dio dio = new Dio();
  Response response = new Response();
  SharedPreferences prefs;

  Future<dynamic> allPayment() async {
    prefs = await SharedPreferences.getInstance();
    int id_user = prefs.getInt('idUser');
    try {
      response = await dio.get(host + '${id_user}');
      if (response.data['message'] != 'dont user') {
        return response.data['message'];
      } else {
        return null;
      }
    } catch (err) {
      print(err);
      print('Aqui');
    }
  }

  Future<bool> create(Payment payment) async {
    prefs = await SharedPreferences.getInstance();
    int id_user = prefs.getInt('idUser');
    payment.idUser = '${id_user}';

    try {
      response = await dio.post(
        host,
        data: payment.toJson(),
      );
      print(payment.toJson());
      print(response.data);
      if (response.data['message'] == 'create') {
        return true ;
      } else {
        return false;
      }
    } catch (err) {
      print(err);
    }
  }
}
