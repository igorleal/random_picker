// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'dart:math';

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
  List _items = <String>[];

  void _newItemToList() {
    int size = _items.length;
    setState(() {
      _items.add("Item " + (size + 1).toString());
    });
  }

  void _clearList() {
    setState(() {
      _items.clear();
    });
  }

  void _pickRandom() {
    final size = _items.length;
    final randomIndex = new Random().nextInt(size);
    final String randomPick = _items[randomIndex];
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
          appBar: AppBar(title: Text("Random Picker")),
          body: Center(child: Text(randomPick)));
    }));
  }

  Widget _buildList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _items.length,
        itemBuilder: (context, index) {
          if (_items.isEmpty) {
            return CircularProgressIndicator();
          } else {
            return _singleItemList(index);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Random Picker")),
      body: _buildForm(),
      floatingActionButton: IconButton(
        onPressed: () => _newItemToList(),
        iconSize: 60,
        icon: Icon(
          Icons.add_circle,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildForm() {
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(child: _buildList()),
          Center(
            child: ButtonBar(mainAxisSize: MainAxisSize.min, children: [
              _items.isEmpty ? null : RaisedButton(
                onPressed: () => _clearList(),
                child: const Text('Clear List',
                    style: TextStyle(fontSize: 10, color: Colors.red)),
                color: Colors.white,
              ),
              _items.isEmpty ? null : ElevatedButton(
                  onPressed: () => {
                        if (_formKey.currentState.validate()) {_pickRandom()}
                      },
                  child: const Text('Pick a Random',
                      style: TextStyle(fontSize: 10, color: Colors.white)))
            ]),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Widget _singleItemList(int index) {
    if (_items.length - 1 < index) {
      return Container(child: null);
    } else {
      String singleItem = _items[index];
      String counter = (index + 1).toString();

      return Row(
        children: [
          Expanded(
              flex: 1,
              child: Text(
                counter,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 6,
              child: TextFormField(
                initialValue: singleItem,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text or remove the row';
                  }
                  return null;
                },
              ))
        ],
      );
    }
  }
}
