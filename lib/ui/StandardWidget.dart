import 'package:flutter/material.dart';
import 'package:pfingst_freizeit_quizz/network/Webservice.dart';
import '../model/questions/Standard.dart';

class StandardWidget extends StatefulWidget {
  final Standard question;

  const StandardWidget({Key? key, required this.question}) : super(key: key);

  @override
  State<StandardWidget> createState() => _StandardWidgetState();
}

class _StandardWidgetState extends State<StandardWidget> {
  String? currentAnswer;

  bool lock = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.question.title),
      ]
        ..addAll(getAnswerRadibuttons(widget.question.answers))
        ..add(TextButton(
            onPressed: lock?null: () async {
              if (currentAnswer == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Bitte erst Antwort auswählen"),
                  ),
                );
              } else {
                if (await sendAnswerStandard(
                    question: widget.question, answer: currentAnswer!)) {
                  setState(() {
                    lock = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                      Text("Antwort abgesendet."),
                    ),
                  );
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Ein Fehler ist aufgetreten. So ein mist."),
                    ),
                  );
                }
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
              if (!lock) {
                setState(() {
                  currentAnswer = value;
                });
              }
            },
          ),
        ),
      )
      .toList();
}
