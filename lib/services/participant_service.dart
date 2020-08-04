import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:event_management_app/models/participant.dart';

class ParticipantService {

  /// This function saves the users on the system
  /// @param newParticipant is a Participant object which contains the
  /// information about new participant.
  /// @return HTTP response object
  Future<http.Response> saveUser(Participant newParticipant) async {
    print("Save user");
    print(newParticipant.identityNumber);
    print(newParticipant.firstName);
    print(newParticipant.lastName);
    print(newParticipant.password);
    print(newParticipant.email);
    print(newParticipant.age);
    print(newParticipant.userName);
    http.Response response =
        await http.post('http://10.0.2.2:8080/participants/create-new-participant',
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
      print("New participant is saved!");
      return response;
    } else {
      /* print(response.statusCode);
      throw Exception("Failed to save a new participant!");*/
      print(response.body);
      return response;
    }
  }
}
