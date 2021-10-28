import 'dart:convert';

import 'package:pfingst_freizeit_quizz/model/questions/Guess.dart';
import 'package:pfingst_freizeit_quizz/model/questions/Order.dart';
import 'package:pfingst_freizeit_quizz/model/questions/Standard.dart';

import '../main.dart';

import '../model/questions/Question.dart';
import 'package:http/http.dart' as http;

String url = "http://192.168.178.59:80";

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
    return response.statusCode == 200;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<void> receiveQuestion() async {
  try {
    final response =
        await http.get(Uri.parse('$url'));
    final json = jsonDecode(response.body);
    Question question = jsonToQuestion(json);
    if (currentQuestion?.title != question.title) {
      currentQuestionStreamController.sink.add(question);
    }
  } catch (e) {
    print(e);
  }
}

Question jsonToQuestion(Map<String, dynamic> json) {
  switch (json['questionType']) {
    case 'standard':
      return Standard(
          title: json['title'], answers: json['answers'].whereType<String>().toList() , id: json['id']);
    case 'schaetzen':
      return Guess(
        title: json['title'],
        id: json['id'],
      );
    case 'sortier':
      return Order(
          title: json['title'], answers: json['answers'].whereType<String>().toList() , id: json['id']);
  }
  throw Error();
}
