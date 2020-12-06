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
  List _controllers = <TextEditingController>[];

  void _newItemToList() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  void _removeItem(index) {
    setState(() {
      _controllers.removeAt(index);
    });
  }

  void _clearList() {
    setState(() {
      _controllers.clear();
    });
  }

  void _pickRandom() {
    final size = _controllers.length;
    final randomIndex = new Random().nextInt(size);
    final String randomPick = _controllers[randomIndex].text;
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
        itemCount: _controllers.length,
        itemBuilder: (context, index) {
          if (_controllers.isEmpty) {
            return CircularProgressIndicator();
          } else {
            return _singleItemList(index);
          }
        });
  }

  @override
  void dispose() {
    _controllers.forEach((element) { element.dispose(); });
    super.dispose();
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
    final _form = GlobalKey<FormState>();

    return Form(
      key: _form,
      child: Column(
        children: [
          Expanded(child: _buildList()),
          Center(
            child: ButtonBar(mainAxisSize: MainAxisSize.min, children: [
              _controllers.isEmpty
                  ? null
                  : RaisedButton(
                      onPressed: () => _clearList(),
                      child: const Text('Remove All',
                          style: TextStyle(fontSize: 10, color: Colors.red)),
                      color: Colors.white,
                    ),
              _controllers.isEmpty
                  ? null
                  : ElevatedButton(
                      onPressed: () => {
                            if (_form.currentState.validate())
                              {_pickRandom()}
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
    if (_controllers.length - 1 < index) {
      return Container(child: null);
    } else {
      final controller = _controllers[index];
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
              flex: 5,
              child: TextFormField(
                controller: controller,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text or remove the row';
                  }
                  return null;
                },
              )),
          Expanded(
              flex: 1,
              child: Center(
                  child: IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () => _removeItem(index))))
        ],
      );
    }
  }
}
