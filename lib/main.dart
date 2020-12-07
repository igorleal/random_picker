// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:RandomPicker/list_item_form.dart';
import 'package:RandomPicker/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/scheduler.dart';

void main() => runApp(RandomPickerApp());

class RandomPickerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Random Picker', home: Items());
  }
}

class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  List _controllers = <TextEditingController>[];
  final _scrollController = ScrollController();

  void _newItemToList() {
    setState(() {
      _controllers.add(TextEditingController());
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  void _removeItem(int index) {
    setState(() {
      _controllers.removeAt(index);
    });
  }

  void _pickRandom() {
    final size = _controllers.length;
    final randomIndex = new Random().nextInt(size);
    final String randomPick = _controllers[randomIndex].text;
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => ResultPage(randomPick: randomPick)));
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
        },
        controller: _scrollController);
  }

  @override
  void dispose() {
    _controllers.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Random Picker")), body: _buildForm());
  }

  Widget _buildForm() {
    final _form = GlobalKey<FormState>();

    return Form(
      key: _form,
      child: Column(
        children: [
          Expanded(
              child: _controllers.isEmpty
                  ? Center(
                      child: Text(
                      "Use the button to add items to the list",
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ))
                  : _buildList()),
          IconButton(
            onPressed: () => _newItemToList(),
            iconSize: 60,
            icon: Icon(
              Icons.add_circle,
              color: Colors.blue,
            ),
          ),
          _controllers.isEmpty
              ? Container()
              : Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () => {
                            if (_form.currentState.validate()) {_pickRandom()}
                          },
                      child: const Text('Pick a Random',
                          style: TextStyle(fontSize: 45, color: Colors.white))))
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Widget _singleItemList(int index) {
    if (_controllers.length - 1 < index) {
      return Container(child: null);
    } else {
      return ListItemForm(
          controller: _controllers[index],
          removeItemFunction: _removeItem,
          index: index
      );
    }
  }
}
