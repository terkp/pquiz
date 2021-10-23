import 'package:flutter/material.dart';
import 'package:pfingst_freizeit_quizz/model/questions/Guess.dart';

class GuessWidget extends StatefulWidget {
  final Guess question;

  const GuessWidget({Key? key, required this.question}) : super(key: key);

  @override
  State<GuessWidget> createState() => _GuessWidgetState();
}

class _GuessWidgetState extends State<GuessWidget> {
  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return Column(children: [
      Text(widget.question.title),
      TextField(
        controller: textController,
        keyboardType: TextInputType.number,
      ),
      TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            final answer = textController.value.text;
            final guess = int.tryParse(answer);
            if (guess != null) {
              //Todo senden
              print(guess);
              if(guess == 42){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Immer eine gute Wahl ;)"),
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(answer.contains(".") || answer.contains(",")
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
