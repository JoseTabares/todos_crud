import 'package:flutter/material.dart';
import 'package:todos_crud/models/todo.dart';

class TodoItemWidget extends StatelessWidget {
  final Todo todo;
  final VoidCallback deleteOnPressed;
  final GestureTapCallback onTap;

  const TodoItemWidget({
    Key key,
    @required this.todo,
    @required this.deleteOnPressed,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(todo.title),
        subtitle: Text(todo.subtitle),
        leading: CircleAvatar(
          child: Text(_getTwoLetters(todo.title)),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: deleteOnPressed,
        ),
      ),
    );
  }

  String _getTwoLetters(String title) {
    return title.substring(0, 2);
  }
}
