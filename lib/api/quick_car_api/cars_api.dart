import 'package:http_parser/http_parser.dart' as http_parser;

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geopoint/geopoint.dart';
import 'package:intl/intl.dart';
import "package:latlong/latlong.dart" as latLng;
import 'package:location/location.dart' as loc;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:quick_car/constants/strings.dart';
import 'package:quick_car/data_class/quick_car/car_data.dart';
import 'package:quick_car/models/distance.dart';

class CarsApi {
  Future<List<CarData>> getCars (String values) {}
  Future<CarData> postCar(CarData cd) async {}
  Future<CarData> postCarDates(int carId, DatePeriod datePeriod) async {}

}
class MockCarsApi implements CarsApi {
  Future<CarData> postCar(CarData cd) async {
    return Future.value(cd);
  }
  Future<CarData> postCarDates(int carId, DatePeriod datePeriod) async {}

  Future<List<CarData>> getCars(String values) async {

    List<CarData> myCars = [];
    //in barcelona
    CarData c1 = CarData("Toyota", "corola", 2000, 100, 41.379442728352956, 2.1745192577523897, 20, "type", File("assets/car-marker.png"), null);
    // in haifa
    CarData c2 = CarData("Lamborghini", "urus", 2000, 100, 32.79267669372492, 34.96627087007497, 83, "type", File("assets/car-marker.png"), null);
    // in natanya
    CarData c3 = CarData("Mazda", "3", 2000, 100, 32.321729568783596, 34.853245583334164, 25, "type", File("assets/car-marker.png"), null);
    // in tel aviv
    CarData c4 = CarData("Fiat", "punto", 2000, 100, 32.06958528877455, 34.778709066764286, 42, "type", File("assets/car-marker.png"), null);
    // in bogota
    CarData c5 = CarData("Alfa romeo", "mito", 2000, 100, 32.1849943444725, 34.87242912320865, 43, "type", File("assets/car-marker.png"), null);
    // in moscow
    CarData c6 = CarData("Maserati", "ghibli", 2000, 100, 55.7465132612745, 37.59436084180872, 51, "type", File("assets/car-marker.png"), null);
    // in istanbul
    CarData c7 = CarData("Renault", "cilo", 2000, 100, 41.04538783080558, 28.91196439894364, 41, "type", File("assets/car-marker.png"), null);
    // in cairo
    CarData c8 = CarData("Subaru", "brz", 2000, 100, 30.040450599576403, 31.23889750389139, 26, "type", File("assets/car-marker.png"), null);
    // in ramat-gan
    CarData c9 = CarData("Opel", "astra", 2000, 100, 32.0840228760379, 34.81408500246813, 33, "type", File("assets/car-marker.png"), null);
    // in bar-ilan
    CarData c10 = CarData("Citroen", "c3", 2000, 100, 32.06840548949039, 34.84274968708446, 29, "type", File("assets/car-marker.png"), null);

    return Future.delayed(
        Duration(seconds: 2), () async {
      myCars.add(c1);
      myCars.add(c2);
      myCars.add(c3);
      myCars.add(c4);
      myCars.add(c5);
      myCars.add(c6);
      myCars.add(c7);
      myCars.add(c8);
      myCars.add(c9);
      myCars.add(c10);
      final _myLocation = await loc.Location().getLocation();
      c1.distanceFromLocation =  calculateDistance(_myLocation.latitude, _myLocation.longitude, c1.latitude, c1.longitude);
      c2.distanceFromLocation =  calculateDistance(_myLocation.latitude, _myLocation.longitude, c2.latitude, c2.longitude);
      c3.distanceFromLocation =  calculateDistance(_myLocation.latitude, _myLocation.longitude, c3.latitude, c3.longitude);
      c4.distanceFromLocation =  calculateDistance(_myLocation.latitude, _myLocation.longitude, c4.latitude, c4.longitude);
      c5.distanceFromLocation =  calculateDistance(_myLocation.latitude, _myLocation.longitude, c5.latitude, c5.longitude);
      c6.distanceFromLocation =  calculateDistance(_myLocation.latitude, _myLocation.longitude, c6.latitude, c6.longitude);
      c7.distanceFromLocation =  calculateDistance(_myLocation.latitude, _myLocation.longitude, c7.latitude, c7.longitude);
      c8.distanceFromLocation =  calculateDistance(_myLocation.latitude, _myLocation.longitude, c8.latitude, c8.longitude);
      c9.distanceFromLocation =  calculateDistance(_myLocation.latitude, _myLocation.longitude, c9.latitude, c9.longitude);
      c10.distanceFromLocation =  calculateDistance(_myLocation.latitude, _myLocation.longitude, c10.latitude, c10.longitude);

      if (values == Strings.SORT_BY_PRICE_CHEAP_TO_EXP){
        myCars.sort((a, b)=> a.pricePerDayUsd.compareTo(b.pricePerDayUsd));
      } else if (values == Strings.SORT_BY_PRICE_EXP_TO_CHEAP) {
        myCars.sort((a, b)=> b.pricePerDayUsd.compareTo(a.pricePerDayUsd));
      } else if (values == Strings.SORT_BY_DISTANCE) {
        myCars.sort((a, b){
          return a.distanceFromLocation.compareTo(
              b.distanceFromLocation.toInt()
          );
        });
      }
      c1.placeMarks = await placemarkFromCoordinates(c1.latitude, c1.longitude);
      c2.placeMarks = await placemarkFromCoordinates(c2.latitude, c2.longitude);
      c3.placeMarks = await placemarkFromCoordinates(c3.latitude, c3.longitude);
      c4.placeMarks = await placemarkFromCoordinates(c4.latitude, c4.longitude);
      c5.placeMarks = await placemarkFromCoordinates(c5.latitude, c5.longitude);
      c6.placeMarks = await placemarkFromCoordinates(c6.latitude, c6.longitude);
      c7.placeMarks = await placemarkFromCoordinates(c7.latitude, c7.longitude);
      c8.placeMarks = await placemarkFromCoordinates(c8.latitude, c8.longitude);
      c9.placeMarks = await placemarkFromCoordinates(c9.latitude, c9.longitude);
      c10.placeMarks = await placemarkFromCoordinates(c10.latitude, c10.longitude);

      return myCars;
    });
  }

}
class QuickCarCarsApi implements CarsApi {
  var client = http.Client();

  Future<CarData> postCarDates(int carId, DatePeriod datePeriod) async {
    print("in post");
    var uri = Uri.parse(Strings.QUICKCAR_URL + "cars/cardates/");
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    print("date: " + formatter.format(datePeriod.start));
    try {
      Map body = { 'dateFrom': formatter.format(datePeriod.start), 'dateTo': formatter.format(datePeriod.end),'car': carId };
      var res = await http.post(uri,
          headers: {
            'Content-Type':'application/json',
          },
          body: jsonEncode(body));
      if (res.statusCode == 201) {
        print("car dates successful");
      }
    } catch (e) {
      print(e);
    }

  }

  Future<CarData> postCar(CarData cd) async {
    var stream = new http.ByteStream(DelegatingStream.typed(cd.image1.openRead()));
    var length = await cd.image1.length();

    var uri = Uri.parse(Strings.QUICKCAR_URL + "cars/");

    var request = http.MultipartRequest("POST", uri)
    ..fields['year'] = cd.year.toString()..fields['type'] = cd.type..fields['brand'] = cd.brand
    ..fields['model']=cd.model..fields['kilometers']=cd.kilometers.toString()..fields['longitude'
      ]=cd.longitude.toString()..fields['latitude']=cd.latitude.toString()..
      fields['price_per_day_usd']=cd.pricePerDayUsd.toString();

    var multipartFile = http.MultipartFile('image1', stream, length,
        filename: basename(cd.image1.path), contentType: new http_parser.MediaType('image', 'png'));



    request.files.add(multipartFile);
    request.headers['Authorization']= 'TOKEN ' + Strings.TOKEN;
    print("requset" +request.fields.toString());
    final response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 201) {
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        cd.id = json.decode(value)['id'];
        print("id: " + cd.id.toString());
      });
      return cd;
    }
    throw Exception("Failed to post car");

  }

  void setLocation(loc.LocationData _myLoc, CarData cd) {
    if (cd.longitude == null || cd.latitude == null) {
      return;
    }
    cd.distanceFromLocation = calculateDistance(_myLoc.latitude, _myLoc.longitude, cd.latitude, cd.longitude);
  }
  Future<List<CarData>> upgradeCars(String responseBody) async {
    final _myLocation = await loc.Location().getLocation();
    Map carsMap = json.decode(responseBody) as Map<String, dynamic>;
    List<CarData> list = [];
    for(int i = 0; i < carsMap['cars'].length; i++) {
      CarData cd = CarData.fromJson(carsMap['cars'][i]);
      setLocation(_myLocation, cd);
      // TODO: get out of this condition
      if (cd.latitude == null || cd.longitude == null) {
        continue;
      }

      list.add(cd);
    }
    return list;
  }

  Future<List<CarData>> getCars(String values) async {
    var client = http.Client();
    Future<List<CarData>> result;
    try {
      var url = Strings.QUICKCAR_URL + "cars/";
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        jsonString = "{" + '"cars":' + jsonString + "}";
        result = upgradeCars(jsonString);

      }
    } catch (Exception) {
      print("error");
    }
    return result;

  }

}