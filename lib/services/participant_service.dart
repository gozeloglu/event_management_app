import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:event_management_app/models/participant.dart';

class ParticipantService {
  /// This function saves the users on the system
  /// @param newParticipant is a Participant object which contains the
  /// information about new participant.
  /// @return HTTP response object
  Future<http.Response> saveUser(Participant newParticipant) async {
    http.Response response = await http.post(
        'http://10.0.2.2:8080/participants/create-new-participant',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "firstName": newParticipant.firstName,
          "lastName": newParticipant.lastName,
          "email": newParticipant.email,
          "userName": newParticipant.userName,
          "password": newParticipant.password,
          "age": newParticipant.age,
          "identityNumber": newParticipant.identityNumber,
        }));

    if (response.statusCode < 400) {
      return response;
    } else {
      return response;
    }
  }

  Future<http.Response> loginParticipant(
      String username, String password) async {
    http.Response response =
        await http.post('http://10.0.2.2:8080/participants/login',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              "firstName": "",
              "lastName": "",
              "email": "",
              "username": username,
              "password": password,
              "age": 20,
              "identityNumber": ""
            }));
    if (response.statusCode < 400) {
      return response;
    } else {
      return response;
    }
  }

  Future<List<dynamic>> getAllMeetups() async {
    http.Response response = await http.get(
        "http://10.0.2.2:8080/participants/all-meetups",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode < 400) {
      return (json.decode(response.body) as List);
    } else {
      throw new Exception("Failed to get meetups");
    }
  }
}
