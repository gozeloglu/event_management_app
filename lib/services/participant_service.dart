import 'package:event_management_app/models/meetup.dart';
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

  /// METHOD POST
  /// This method satisfies the login operation for participants
  /// @param username is the unique username of the participant
  /// who wants to login the system
  /// @param password is participant's unique password
  /// @return HTTP Response object
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

  /// METHOD: GET
  /// This function fetches the list of meetup for participants
  /// @return List of Meetup object
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

  /// METHOD: GET
  /// This method fetches the meetup details of the given meetup id
  /// @param meetupID specifies the id of the meetup that we want to get details
  /// @return Meetup object which includes the information about meetup
  Future<Meetup> getMeetupDetails(String meetupID) async {
    http.Response response = await http.get(
        "http://10.0.2.2:8080/participants/meetup-detail/" + meetupID,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode < 400) {
      return Meetup.fromJson(json.decode(response.body));
    } else {
      throw new Exception("Meetup could not found!");
    }
  }
}
