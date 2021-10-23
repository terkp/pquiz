import 'package:flutter/material.dart';
import 'package:pfingst_freizeit_quizz/model/questions/Standard.dart';

class StandardWidget extends StatefulWidget {
  final Standard question;

  const StandardWidget({Key? key, required this.question}) : super(key: key);

  @override
  State<StandardWidget> createState() => _StandardWidgetState();
}

class _StandardWidgetState extends State<StandardWidget> {
  String? currentAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.question.title),
      ]
        ..addAll(getAnswerRadibuttons(widget.question.answers))
        ..add(TextButton(
            onPressed: () {
              if (currentAnswer == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Bitte erst Antwort auswählen"),
                  ),
                );
              }else {
                //Todo currentAnswerSenden
              }
            },
            child: Text("Absenden"))),
    );
  }

  List<Widget> getAnswerRadibuttons(List<String> answers) => answers
      .map(
        (answer) => ListTile(
          title: Text(answer),
          leading: Radio<String>(
            value: answer,
            groupValue: currentAnswer,
            onChanged: (String? value) {
              setState(() {
                currentAnswer = value;
              });
            },
          ),
        ),
      )
      .toList();
}
