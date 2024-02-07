import 'package:flutter/material.dart';
import 'package:flutter_todo_application/components/dialog_box.dart';
import 'package:flutter_todo_application/components/todo_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 //text controller
 final _controller = TextEditingController(); 
 
 
 
  //list of tasks
  // List toDoList = [
  //   ["make dinner", false],
  //   ["buy milk",true],
  //   ["buy eggs", false],
  //   ["buy bread", true],
  // ];

  //After using shared pref change the list is loaded

  List toDoList = [];

  @override
  void initState() {
    super.initState();
    loadToDoList();
  }



void saveToDoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> toDoListString = toDoList.map((item) => '${item[0]},${item[1]}').toList();
  prefs.setStringList('toDoList', toDoListString);
}

void loadToDoList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? toDoListString = prefs.getStringList('toDoList');
  if (toDoListString != null) {
    setState(() {
      toDoList = toDoListString.map((item) {
        var split = item.split(',');
        return [split[0], split[1] == 'true'];
      }).toList();
    });
  }
}

 void onChanged(bool? isChecked, int index) {
    setState(() {
      toDoList[index][1] = isChecked!;
      saveToDoList();
    });
  }
  //function of the add button
  void addTaskToList() {
    setState(() {
      toDoList.add([_controller.text, false]);
      saveToDoList();
      _controller.clear();
      Navigator.pop(context);
    });
  }
  //function to add a task
  void addTask () {
    showDialog(context: context, builder: (context) {
      return DialogBox(
        controller: _controller,
        onAdd: addTaskToList,
      );
    });
  }
  //function to delete a task
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
      saveToDoList();
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(title: const Text('Todo App')),
        body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: toDoList[index][0],
              isChecked: toDoList[index][1],
              onChanged: (bool? isChecked) => onChanged(isChecked, index),
              deleteTask: (context) => deleteTask(index),
            );
          },
        ),
        floatingActionButton:  FloatingActionButton(onPressed: addTask,
        child: Icon(Icons.add)),);
  }
}