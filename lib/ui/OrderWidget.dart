import 'package:flutter/material.dart';
import 'package:pfingst_freizeit_quizz/model/questions/Order.dart';
import 'package:pfingst_freizeit_quizz/model/questions/Standard.dart';

class OrderWidget extends StatefulWidget {
  final Order question;

  const OrderWidget({Key? key, required this.question}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  String? currentAnswer;

  @override
  Widget build(BuildContext context) {
    List<String> _items = widget.question.answers;
    return Column(
      children: [
        Text(widget.question.title),
        SizedBox(
          height: _items.length*60,
          child: ReorderableListView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            children: <Widget>[
              for (int index = 0; index < _items.length; index++)
                ListTile(
                  key: Key('$index'),
                  trailing: Icon(Icons.view_headline),
                  title: Text('Item ${_items[index]}'),
                ),
            ],
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final String item = _items.removeAt(oldIndex);
                _items.insert(newIndex, item);
              });
            },
          ),
        ),
        TextButton(
          child: Text("Absenden"),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Abbrechen"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      //Todo absenden
                    },
                    child: Text("Ok"),
                  )
                ],
              ),
            );
          },
        )
      ],
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
