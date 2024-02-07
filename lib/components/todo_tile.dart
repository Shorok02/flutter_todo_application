import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  String taskName;
  bool isChecked;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;
  TodoTile(
      {super.key,
      required this.taskName,
      required this.isChecked,
      required this.onChanged,
      required this.deleteTask,}
      );
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child:
Slidable(
  //end drag from the right start drag from left ig
  endActionPane: ActionPane(
    motion: ScrollMotion(),
    children: [
      SlidableAction(
        onPressed: deleteTask,
        icon: Icons.delete,
        foregroundColor:Colors.white,
        backgroundColor: Colors.red[400]!,
      ),
    ],
  ),
  child: Container(
    decoration: BoxDecoration(
      color: Colors.yellow[100],
    ),
    padding: const EdgeInsets.all(20.0),
    child: Row(children: [
      Checkbox(
        value: isChecked,
        onChanged: onChanged,
        activeColor: Colors.black,
      ),
      Text(taskName,
          style: TextStyle(
              decoration: isChecked ? TextDecoration.lineThrough : null)),
    ]),
  ),
 
),
    ); 
  }
}
