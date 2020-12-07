import 'package:flutter/material.dart';

class ListItemForm extends StatefulWidget {
  final TextEditingController controller;
  final void Function(int) removeItemFunction;
  final int index;

  ListItemForm({this.controller, this.removeItemFunction, this.index});

  @override
  _ListItemFormState createState() => _ListItemFormState(controller: controller, removeItemFunction: removeItemFunction, index: index);
}

class _ListItemFormState extends State<ListItemForm> {
  final TextEditingController controller;
  final void Function(int) removeItemFunction;
  final int index;

  _ListItemFormState({this.controller, this.removeItemFunction, this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text("",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 30))),
        Expanded(
            flex: 10,
            child: TextFormField(
              style: TextStyle(fontSize: 30),
              controller: controller,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text or remove the row';
                }
                return null;
              },
            )),
        Expanded(
            flex: 2,
            child: IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: () => removeItemFunction(index))),
      ],
    );
  }

}