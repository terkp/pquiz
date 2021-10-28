import 'package:flutter/material.dart';
import 'package:pfingst_freizeit_quizz/model/questions/Standard.dart';

class nextquestion extends StatefulWidget {
  @override
  State<nextquestion> createState() => _nextquestionState();
}

class _nextquestionState extends State<nextquestion> {
  bool show1 = false;
  final Stream<int> _gruppen = (() async* {
    await Future<void>.delayed(const Duration(seconds: 2));
    yield 1;
    await Future<void>.delayed(const Duration(seconds: 20));
  })();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[ show1?
      Column(
      children:[
        ElevatedButton(
          onPressed: (){setState(() {
            show1 = false;
          });
          },
          child: Text(
              "Nächste Frage"
          ),
        ),
        ElevatedButton(
          onPressed: (){setState(() {
            show1 = false;
          });
          },
          child: Text(
              "Antworten Anzeigen"
          ),
        ),
        StreamBuilder<int>(
          stream: _gruppen,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          List<Widget> children;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              children = const <Widget>[
                Text('none')
                ];
              break;
            case ConnectionState.waiting:
              children = const <Widget>[
                Text('waiting')
              ];
              break;
            case ConnectionState.done:
              children = const <Widget>[
                Text('done')
              ];
              break;
            case ConnectionState.active:
                  children = <Widget>[
                    Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ElevatedButton(
                      onPressed: (){setState(() {
                        show1 = true;
                      });
                      },
                      child: Text(
                          "Antworten Anzeigen"
                      ),
                    )
                    )

          ];
                  break;
            }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          );
          }

        )
      ]):
        ElevatedButton(
          onPressed: (){setState(() {
            show1 = true;
          });
          },
          child: Text(
              "Nouvelle Texte"
          ),
        ),]
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home:nextquestion()));

}