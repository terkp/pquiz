import 'package:flutter/material.dart';
import 'package:pfingst_freizeit_quizz/network/Webservice.dart';
import '../model/questions/Order.dart';

class OrderWidget extends StatefulWidget {
  final Order question;

  const OrderWidget({Key? key, required this.question}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  String? currentAnswer;
  bool lock = false;

  @override
  Widget build(BuildContext context) {
    List<String> _items = widget.question.answers;
    return Column(
      children: [
        Text(widget.question.title),
        SizedBox(
          height: _items.length * 60,
          child: lock
              ? Column(
                  children: <Widget>[
                    for (int index = 0; index < _items.length; index++)
                      ListTile(
                        key: Key('$index'),
                        trailing: Icon(Icons.view_headline),
                        title: Text('Item ${_items[index]}'),
                      ),
                  ],
                )
              : ReorderableListView(
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
                    if (lock) return;
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
          onPressed: lock?null: () {
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
                    onPressed: () async {
                      Navigator.of(context).pop();
                      if (await sendAnswerOrder(
                          question: widget.question, answer: _items)) {
                        setState(() {
                          lock = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                            Text("Ein Fehler ist aufgetreten. So ein mist."),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Ein Fehler ist aufgetreten. So ein mist."),
                          ),
                        );
                      }
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
}
