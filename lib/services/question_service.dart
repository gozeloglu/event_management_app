import 'dart:convert';

import 'package:event_management_app/models/question.dart';
import 'package:http/http.dart' as http;

class QuestionService {

  Future<http.Response> saveNewQuestion(Question question, String meetupID) async {
    http.Response response = await http.post("http://10.0.2.2:8080/question/add-new-question/" + meetupID,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic> {
        "askedQuestion": question.askedQuestion,
        "isAnswered": question.isAnswered,
      })
    );

    if (response.statusCode < 400) {
      return response;
    } else {
      return response;
    }
  }
}