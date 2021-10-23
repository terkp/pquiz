import 'package:flutter/material.dart';
import 'package:pfingst_freizeit_quizz/network/Webservice.dart';
import '../model/questions/Guess.dart';

class GuessWidget extends StatefulWidget {
  final Guess question;

  const GuessWidget({Key? key, required this.question}) : super(key: key);

  @override
  State<GuessWidget> createState() => _GuessWidgetState();
}

class _GuessWidgetState extends State<GuessWidget> {
  bool lock = false;
  int? answerGuess;

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return Column(children: [
      Text(widget.question.title),
      lock
          ? Text("$answerGuess")
          : TextField(
              controller: textController,
              keyboardType: TextInputType.number,
            ),
      TextButton(
          onPressed: lock
              ? null
              : () async {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  final answer = textController.value.text;
                  final guess = int.tryParse(answer);
                  if (guess == 42) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Immer eine gute Wahl ;)"),
                      ),
                    );
                  }
                  if (guess != null) {
                    if (await sendAnswerGuess(
                        question: widget.question, answer: guess)) {
                      setState(() {
                        answerGuess = guess;
                        lock = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                          Text("Antwort abgesendet."),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text("Ein Fehler ist aufgetreten. So ein mist."),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            answer.contains(".") || answer.contains(",")
                                ? "Nur ganze Zahlen erlaubt!"
                                : "Bitte erst gültige Antwort eingeben"),
                      ),
                    );
                  }
                },
          child: Text("Absenden"))
    ]);
  }
}
