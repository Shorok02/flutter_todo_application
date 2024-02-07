import 'package:flutter/material.dart';
import 'package:flutter_todo_application/components/custom_button.dart';

class DialogBox extends StatelessWidget {
  //to listen to the text field
  final controller;
  VoidCallback onAdd;
  DialogBox({super.key, required this.controller, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[100],
      content: Container(
        height: 150,
        child: Column(
          children: [
            const Text("Add a new task"),
            const SizedBox(height: 10),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Enter task here",
              ),
            ),
            CustomButton(text: "Add", onPressed: onAdd)
          ],
        ),
      ),
    );
  }
}
