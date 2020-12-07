import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final String randomPick;

  ResultPage({this.randomPick});

  @override
  _ResultPageState createState() => _ResultPageState(randomPick: randomPick);
}

class _ResultPageState extends State<ResultPage> {
  final String randomPick;

  _ResultPageState({this.randomPick});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Random Picker")),
        body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, children: [Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [Text(
                  "The picked item is: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35.0,
                  ),
                )]) ,
              Row(mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min, children: [Text(
                      randomPick,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold
                      ))]),
            ])
        ));
  }

}