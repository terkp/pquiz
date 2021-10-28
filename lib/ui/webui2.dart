import 'package:flutter/material.dart';
import 'package:pfingst_freizeit_quizz/model/questions/Standard.dart';

class nextquestion extends StatefulWidget {
  @override
  State<nextquestion> createState() => _nextquestionState();
}

class _nextquestionState extends State<nextquestion> {
  bool show1 = false;
  bool groupselct = false;
  var ausgruppe = "";
  List<Map<String, String>> _gruppe = [];
  Stream<List<Map<String, String>>> _gruppen() async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    _gruppe.add({"gruppe1": "2"});
    yield _gruppe;
    await Future<void>.delayed(const Duration(seconds: 5));
    _gruppe.add({"gruppe2": "3"});
    yield _gruppe;
    await Future<void>.delayed(const Duration(seconds: 20));
  }
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
                StreamBuilder(
                    stream: _gruppen(),
                    builder: (BuildContext context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
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
                              child:
                              ListView.builder(
                                  itemCount: _gruppe.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return new GestureDetector(
                                        onTap: () {
                                          print('on tap clicked on ');
                                        },
                                        child:
                                        Container(
                                            height: 45.0,
                                            decoration: BoxDecoration(),
                                            child: new Column(
                                                children: <Widget>[
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          left: 15.0, right: 15.0),
                                                      child: new Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceBetween,
                                                          children: <Widget>[
                                                            new Container(
                                                              child: Text(
                                                                _gruppe[index][0],
                                                                textAlign: TextAlign.left,
                                                                style: TextStyle(
                                                                    fontSize: 10.0),
                                                                maxLines: 1,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius
                                                                      .only(topLeft: Radius
                                                                      .circular(10.0),
                                                                      topRight: Radius
                                                                          .circular(10.0))
                                                              ),
                                                            ),
                                                            new GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  ausgruppe =
                                                                  _gruppe[index][0];
                                                                  groupselct = true;
                                                                });
                                                              },
                                                            )
                                                          ]
                                                      )
                                                  )
                                                ]
                                            )

                                        )
                                    );
                                  }

                                /* ElevatedButton(
                      onPressed: (){setState(() {
                        show1 = true;
                      });
                      },
                      child: Text(
                          '${snapshot.data}'
                      ),
                    ), */
                              ),


                            )

                          ];
                          break;
                      }

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