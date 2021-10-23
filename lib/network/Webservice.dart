import 'dart:convert';

import 'package:pfingst_freizeit_quizz/model/questions/Guess.dart';
import 'package:pfingst_freizeit_quizz/model/questions/Order.dart';
import 'package:pfingst_freizeit_quizz/model/questions/Standard.dart';

import '../main.dart';

import '../model/questions/Question.dart';
import 'package:http/http.dart' as http;

String url = "http://192.168.178.117:8080";

Future<bool> sendAnswerStandard(
    {required Standard question, required String answer}) async {
  return await sendAnswer(question: question, answer: answer);
}

Future<bool> sendAnswerOrder(
    {required Order question, required List<String> answer}) async {
  return await sendAnswer(question: question, answer: answer);
}

Future<bool> sendAnswerGuess(
    {required Guess question, required int answer}) async {
  return await sendAnswer(question: question, answer: answer);
}

Future<bool> sendAnswer(
    {required Question question, required dynamic answer}) async {
  try {
    var response = await http.post(
      Uri.parse('$url/answer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'questionId': question.id,
        'group': groupName!,
        'answer': answer
      }),
    );
    return true; //response.statusCode == 200;
  } catch (e) {
    print(e);
    return true;
  }
}

Future<void> receiveQuestion() async {
  final repsonse = await http.get(Uri.parse('$url'), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });
  final json = jsonDecode(repsonse.body);
  Question question = jsonToQuestion(json);
  if ((await currentQuestion.last).id != question.id) {
    currentQuestionStreamController.sink.add(question);
  }
}

Question jsonToQuestion(Map<String, dynamic> json) {
  switch (json['questionType']) {
    case 'standard':
      return Standard(
          title: json['title'], answers: json['answers'], id: json['id']);
  }
  throw Error();
}
