import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Widgets',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Mein Dashboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// ############################################################################################################################
// ############################################################################################################################
// 
// DATENKLASSEN, OBJEKTE UND ANDERE

class Todo {
  final String title;
  final bool isDone;

  Todo({
    required this.title,
    this.isDone = false
  });
}

//
// ############################################################################################################################
// ############################################################################################################################

// ############################################################################################################################
// ##### ##### ## ##    ##########     ###      ##       ######################################################################
// ##### ##### ## ## ###  ######  ######## ########## #########################################################################
// ##### ##### ## ## ##### #### ########## ########## #########################################################################
// ##### ##### ## ## ###### ## #####   ###      ##### #########################################################################
// ##### ## ## ## ## ##### #### ####### ## ########## #########################################################################
// ##### # # # ## ## ###  ######  ###  ### ########## #########################################################################
// #####  ###  ## ##    ##########   #####      ##### #########################################################################
// ############################################################################################################################

// Widget A - Anzeigen von Todos

class ShowTodos extends StatelessWidget {
  final List<Todo> todos;

  const ShowTodos({
    super.key,
    required this.todos
  });

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];

        return ListTile(
          title: Text(todo.title),
          trailing: Icon(
            todo.isDone ? Icons.check_circle : Icons.circle_outlined
          )
        );
      }
    );
  }
}

// Widget B - Button zum Hinzufügen neuer Todos 

class AddTodos extends StatelessWidget {
  final VoidCallback onPressed;

  const AddTodos({
    super.key,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: onPressed, child: Icon(Icons.add));
  }
}

// ############################################################################################################################
// ############################################################################################################################
// ############################################################################################################################
// ############################################################################################################################
// ############################################################################################################################
// ############################################################################################################################
// ############################################################################################################################
// ############################################################################################################################
// ############################################################################################################################


class _MyHomePageState extends State<MyHomePage> {
  List<Todo> todos = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50
      ),
      body: 
        ShowTodos(todos: todos),
      floatingActionButton: AddTodos(onPressed: _addTodos),
    );
  }

// ############################################################################################################################

// Todo hinzufügen

  void _addTodos() {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Füge eine Todo hinzu"),
          content: TextField(controller: _controller),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  todos.add(Todo(title: _controller.text));
                  _controller.clear();
                });
              }, 
              child: Text("Hinzufügen")
            )
          ],
        );
      }
    );
  }
}
