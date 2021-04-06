import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quick_car/constants/strings.dart';
import 'package:quick_car/data_class/car_model.dart';
import 'package:quick_car/data_class/tests/car_model.dart';

class API {
  Future<Welcome> getCars() async {
    var client = http.Client();
    var result;

    try {
      var url = Strings.CAR_TEST_URL;
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        jsonString = "{" + '"cars":' + jsonString + "}";
        var jsonMap = json.decode(jsonString);
        result = Welcome.fromJson(jsonMap);
      }
    } catch (Exception) {
      print("error");
      return result;
    }
    return result;

  }
}