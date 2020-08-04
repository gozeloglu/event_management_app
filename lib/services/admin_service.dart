import 'dart:convert';

import 'package:event_management_app/models/admin.dart';
import 'package:http/http.dart' as http;

class AdminService {
  Future<http.Response> loginAdmin(Admin admin) async {
    http.Response response = await http.post('http://10.0.2.2:8080/admin/login',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "firstName": "",
          "lastName": "",
          "email": "",
          "username": admin.userName,
          "password": admin.password,
          "age": 20,
          "identityNumber": ""
        }));

    if (response.statusCode < 400) {
      return response;
    } else {
      return response;
    }
  }
}
