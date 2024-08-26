import 'dart:convert';
import 'package:assignment_allisons/models/home_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static const String apiUrl = 'https://swan.alisonsnewdemo.online/api/home?id=bDy&token=UKTlw8cMDVbMJxM6RbV9HaNrVBeU7VTsFejJzKdc';

  static Future<HomeModel> fetchHomeData() async {
    final response = await http.post(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return HomeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}

