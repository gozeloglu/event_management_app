import 'package:event_management_app/models/meetup.dart';
import 'package:flutter/foundation.dart';
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

  /// METHOD POST
  /// This method satisfies the registration of the meetup
  /// @param username specifies the person who wants to attend the meetup
  /// @param meetupID specifies the meetup that the participant wants to attend
  /// @return HTTP Response object
  Future<http.Response> registerMeetup(String username, String meetupID) async {
    http.Response response = await http.post(
        "http://10.0.2.2:8080/participants/register-participant/" +
            username +
            "/" +
            meetupID,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (response.statusCode < 400) {
      return response;
    } else {
      return response;
    }
  }

  /// METHOD GET
  /// This method fetches the participant profile details
  /// @param username specifies the participant who wants to get information
  /// @return Participant model object
  Future<Participant> getParticipantDetails(String username) async {
    http.Response response = await http.get(
        "http://10.0.2.2:8080/participants/participant-detail/" + username,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (response.statusCode < 400) {
      return Participant.fromJson(json.decode(response.body));
    } else {
      throw new Exception("User could not found!");
    }
  }

  /// METHOD PUT
  /// Updates the profile
  /// @param participant contains the updated participant information
  /// @return HTTP Response
  Future<http.Response> updateProfile(Participant participant) async {
    http.Response response = await http.put(
        "http://10.0.2.2:8080/participants/update-profile/" +
            participant.identityNumber,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          "firstName": participant.firstName,
          "lastName": participant.lastName,
          "email": participant.email,
          "username": participant.userName,
          "password": "",
          "age": participant.age,
          "identityNumber": participant.identityNumber,
        }));

    if (response.statusCode < 400) {
      return response;
    } else {
      return response;
    }
  }

  /// METHOD GET
  /// This method fetches the all meetups that participant registered
  /// @param username specifies the participant username that we want to get list
  /// @return List of Meetup object
  Future<List<dynamic>> getMyMeetups(String username) async {
    http.Response response = await http.get(
      "http://10.0.2.2:8080/participants/all-meetups/" + username,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode < 400) {
      return (json.decode(response.body) as List);
    } else {
      throw new Exception("Failed to get meetups");
    }
  }

  Future<http.Response> unRegisterMeetup(String username, String meetupID) async {
    http.Response response = await http.post(
        "http://10.0.2.2:8080/participants/unregister-participant/" +
            username +
            "/" +
            meetupID,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if (response.statusCode < 400) {
      return response;
    } else {
      return response;
    }
  }
}
