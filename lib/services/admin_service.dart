import 'dart:convert';

import 'package:event_management_app/models/admin.dart';
import 'package:event_management_app/models/meetup.dart';
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

  Future<http.Response> addNewMeetup(Meetup meetup) async {
    print(meetup.endDate);
    print(meetup.startDate);
    print(meetup.meetupName);
    http.Response response =
        await http.post("http://10.0.2.2:8080/meetups/create-new-meetup",
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              "meetupID": meetup.meetupID,
              "meetupName": meetup.meetupName,
              "details": meetup.details,
              "address": meetup.address,
              "placeName": meetup.placeName,
              "startDate": meetup.startDate,
              "endDate": meetup.endDate,
              "quota": meetup.quota,
              "registeredUserCount": meetup.registeredCount,
            }));

    print(response.statusCode);
    if (response.statusCode < 400) {
      return response;
    } else {
      return response;
    }
  }
}
