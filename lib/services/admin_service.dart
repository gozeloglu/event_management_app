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
    print("HTTP FUNCTION");
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

  Future<List<dynamic>> getAllMeetups() async {
    http.Response response = await http
        .get("http://10.0.2.2:8080/meetups", headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode < 400) {
      return (json.decode(response.body) as List);
    } else {
      throw new Exception("Failed to load meetups");
    }
  }

  Future<Meetup> getMeetup(String meetupID) async {
    http.Response response = await http.get(
        "http://10.0.2.2:8080/meetups/" + meetupID,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode < 400) {
      return Meetup.fromJson(json.decode(response.body));
    } else {
      throw new Exception("Meetup could not found!");
    }
  }

  Future<http.Response> updateMeetup(Meetup meetup) async {
    http.Response response = await http.put(
        "http://10.0.2.2:8080/meetups/update-meetup/" + meetup.meetupID,
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

    if (response.statusCode < 400) {
      return response;
    } else {
      return response;
    }
  }
}
