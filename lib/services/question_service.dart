import 'dart:convert';

import 'package:event_management_app/models/question.dart';
import 'package:http/http.dart' as http;

class QuestionService {
  Future<http.Response> saveNewQuestion(
      Question question, String meetupID) async {
    http.Response response = await http.post(
        "http://10.0.2.2:8080/question/add-new-question/" + meetupID,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "askedQuestion": question.askedQuestion,
          "isAnswered": question.isAnswered,
        }));

    if (response.statusCode < 400) {
      return response;
    } else {
      return response;
    }
  }

  Future<List<dynamic>> getQuestions(String meetupID) async {
    print("get questions $meetupID");
    http.Response response = await http.get(
        "http://10.0.2.2:8080/question/all-questions/" + meetupID,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    print(response.statusCode);
    if (response.statusCode < 400) {
      return (json.decode(response.body) as List);
    } else {
      throw new Exception("Failed to get questions");
    }
  }

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
