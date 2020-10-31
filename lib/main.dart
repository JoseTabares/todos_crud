import 'package:flutter/material.dart';
import 'package:todos_crud/add_todo_page.dart';
import 'package:todos_crud/models/todo.dart';
import 'package:todos_crud/todo_item_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonColor: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> _todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODOs'),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          return TodoItemWidget(
            todo: _todos[index],
            deleteOnPressed: () {
              _confirmDeleteTodo(index);
            },
            onTap: () {
              _openCreateTodoPage(todo: _todos[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openCreateTodoPage();
        },
      ),
    );
  }

  void _openCreateTodoPage({Todo todo}) {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: todo),
    ))
        .then((value) {
      if (value != null) {
        _addTodoToList(value);
      }
    });
  }

  void _addTodoToList(Todo todo) {
    setState(() {
      var index = _todos.indexWhere((element) => element.id == todo.id);
      if (index == -1) {
        _todos.add(todo);
      } else {
        _todos[index] = todo;
      }
    });
  }

  void _confirmDeleteTodo(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Borrar todo'),
        content: Text('¿Estás seguro de borrar este TODO?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Eliminar'),
          ),
        ],
      ),
    ).then((value) {
      if (value != null && value) {
        _deteleTodo(index);
      }
    });
  }

  void _deteleTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }
}
