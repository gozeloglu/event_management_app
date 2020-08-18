import 'dart:convert';

import 'package:event_management_app/models/question.dart';
import 'package:http/http.dart' as http;

class QuestionService {
  /// METHOD POST
  /// This method saves the new question to question table in database
  /// @param question is a Question object which stores the question text and
  /// meetup id
  /// @param meetupID is the id of the question that
  /// we want to match with question
  /// @return HTTP Response object
  Future<http.Response> saveNewQuestion(Question question, int meetupID) async {
    http.Response response = await http.post(
        "http://10.0.2.2:8080/question/add-new-question/" + meetupID.toString(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "askedQuestion": question.askedQuestion,
          "isAnswered": question.isAnswered,
          "meetupID": meetupID
        }));

    if (response.statusCode < 400) {
      return response;
    } else {
      return response;
    }
  }

  /// METHOD GET
  /// This method fetches the all questions by given meetup id
  /// @param meetupID is the id of the meetup that we want to
  /// get all questions for given meetup
  /// @return List of questions
  Future<List<dynamic>> getQuestions(int meetupID) async {
    http.Response response = await http.get(
        "http://10.0.2.2:8080/question/all-questions/" + meetupID.toString(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode < 400) {
      return (json.decode(response.body) as List);
    } else {
      throw new Exception("Failed to get questions");
    }
  }

  /// METHOD DELETE
  /// Question is being deleted if the question is answered
  /// @param questionID is the id of the meetup that we want to delete it
  /// @return HTTP Response
  Future<http.Response> deleteQuestion(int questionID) async {
    http.Response response = await http.delete(
        "http://10.0.2.2:8080/question/delete-question/" +
            questionID.toString(),
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
