// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';

void main() => runApp(RandomPickerApp());

class RandomPickerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Picker',            
      home: Items(),
    );
  }
}

class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {

  final _items = <String>["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"];

  Widget _buildList() {
      return 
      Column(
        
        children: [
            
            Padding(
              padding: EdgeInsets.all(25.0),
              child: RaisedButton(
              onPressed: () {},
            child: const Text('Pick a random item', style: TextStyle(fontSize: 30, color: Colors.white)),
            color: Colors.blue,
            ))
          ,
          Expanded(child: ListView.separated(
        padding: EdgeInsets.all(10.0),
        itemCount: _items.length,
        itemBuilder: (context, i) {
          return _buildRow(_items[i]);
        },
        separatorBuilder: (context, i) => Divider(),
        )),
        IconButton(
            onPressed: () {},
            iconSize: 60,
            icon: Icon(
              Icons.add_circle,
              color: Colors.blue,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25.0),
              child: RaisedButton(
              onPressed: () {},
            child: const Text('Clear list', style: TextStyle(fontSize: 20, color: Colors.red)),
            ),
            )
        ]
        )
      ;
  }

Widget _buildRow(String item) {
  return ListTile(
    title: Text(
      item,
    ),
  );
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildList(),
    );
  }
}