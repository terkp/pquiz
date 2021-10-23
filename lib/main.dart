import 'dart:async';

import 'package:flutter/material.dart';
import 'model/questions/Order.dart';
import 'model/questions/Question.dart';
import 'model/questions/Standard.dart';
import 'ui/GuessWidget.dart';
import 'ui/OrderWidget.dart';
import 'ui/StandardWidget.dart';
import 'model/questions/Guess.dart';

void main() {
  currentQuestionStreamController = StreamController<Question>();
  currentQuestion = currentQuestionStreamController.stream;
  currentQuestionStreamController.sink.add(Guess(title: "Frage1", id: 2));
  Future.delayed(Duration(seconds: 20)).then((value) =>
      currentQuestionStreamController.sink.add(Standard(
          title: "Frage2", id: 2, answers: ["Antwort 1", "Antwort 2"])));
  Future.delayed(Duration(seconds: 40)).then((value) =>
      currentQuestionStreamController.sink.add(
          Order(title: "Frage 3", id: 2, answers: ["Antwort 1", "Antwort 2"])));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pfingstfreizeit Quizz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: StreamBuilder<Question>(
          builder: (_, snapshot) => snapshot.hasData
              ? getWidgetForQuestion(snapshot.data!)
              : Text("Nix"),
          stream: currentQuestion,
        ),
      ),
    );
  }
}

Widget getWidgetForQuestion(Question question) {
  if (question is Standard) return StandardWidget(question: question);
  if (question is Guess) return GuessWidget(question: question);
  if (question is Order) return OrderWidget(question: question);
  throw Error();
}

late Stream<Question> currentQuestion;
late StreamController<Question> currentQuestionStreamController;
