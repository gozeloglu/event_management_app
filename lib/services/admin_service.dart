import 'dart:convert';

import 'package:event_management_app/models/admin.dart';
import 'package:event_management_app/models/admin_dto.dart';
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
  Future<Meetup> getMeetup(int meetupID) async {
    http.Response response = await http.get(
        "http://10.0.2.2:8080/meetups/" + meetupID.toString(),
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
  Future<http.Response> updateMeetup(int meetupID, Meetup meetup) async {
    http.Response response = await http.put(
        "http://10.0.2.2:8080/meetups/update-meetup/" + meetupID.toString(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
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
  Future<http.Response> deleteMeetup(int meetupID) async {
    http.Response response = await http.delete(
        "http://10.0.2.2:8080/meetups/delete-meetup/" + meetupID.toString(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode < 400) {
      return response;
    } else {
      return response;
    }
  }

  /// METHOD: GET
  /// This method returns all participants who are registered to the
  /// meetup which is given as a parameter
  /// @param meetupID is the id of the meetup which we want to fetch
  /// participant list
  /// @return List of Participant objects
  Future<List<dynamic>> listAllParticipants(int meetupID) async {
    http.Response response = await http.get(
        "http://10.0.2.2:8080/admin/all-participants/" + meetupID.toString(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode < 400) {
      return (json.decode(response.body) as List);
    } else {
      throw new Exception("Failed to fetch participants");
    }
  }

  /// METHOD: GET
  /// This method returns the details of the admin
  /// @param username is the admin's username
  /// @return AdminDTO object which includes information of the admin
  Future<AdminDTO> getAdminDetails(String username) async {
    http.Response response = await http.get(
        "http://10.0.2.2:8080/admin/admin-details/" + username,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode < 400) {
      return AdminDTO.fromJson(json.decode(response.body));
    } else {
      throw new Exception("Admin could not found!");
    }
  }
}
