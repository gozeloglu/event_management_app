import 'dart:convert';

import 'package:event_management_app/models/admin.dart';
import 'package:event_management_app/models/meetup.dart';
import 'package:http/http.dart' as http;

class AdminService {
  /// METHOD: POST
  /// This method provides the login operation for admin
  /// @param admin is a Admin object which includes username and password
  /// @return HTTP response object
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

  /// METHOD: POST
  /// This method creates a new meetup and saves on the database
  /// @param meetup includes Meetup object which includes meetup attributes
  /// @return HTTP Response object
  Future<http.Response> addNewMeetup(Meetup meetup) async {
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

    if (response.statusCode < 400) {
      return response;
    } else {
      return response;
    }
  }

  /// METHOD: GET
  /// This method fetches all meetups and returns a list
  /// @return List of meetup objects
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

  /// METHOD: GET
  /// This method fetches the details of the given meetup id
  /// @param meetupID specifies the id of the meetup that we want to get details
  /// @return Meetup object of the given meetup id details
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

  /// METHOD: PUT
  /// This method updates the given meetup
  /// @param meetupID is the id of the given meetup
  /// @param meetup is the object of the updated object
  /// @return HTTP Response object
  Future<http.Response> updateMeetup(String meetupID, Meetup meetup) async {
    http.Response response =
        await http.put("http://10.0.2.2:8080/meetups/update-meetup/" + meetupID,
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

  /// METHOD: DELETE
  /// This method deletes the meetup which is given as a parameter
  /// @param meetupID is id of the meetup that we want to delete
  /// @return HTTP Response object
  Future<http.Response> deleteMeetup(String meetupID) async {
    print("id " + meetupID);
    http.Response response = await http.delete(
        "http://10.0.2.2:8080/meetups/delete-meetup/" + meetupID,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode < 400) {
      return response;
    } else {
      return response;
    }
  }
}
