import 'package:flutter/material.dart';
import 'package:todos_crud/models/todo.dart';
import 'package:uuid/uuid.dart';

class AddTodoPage extends StatefulWidget {
  final Todo todo;

  const AddTodoPage({
    Key key,
    this.todo,
  }) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();

  String _titleError;
  String _subtitleError;

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _titleController.text = widget.todo.title;
      _subtitleController.text = widget.todo.subtitle;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? 'Crear TODO' : 'Actualizar TODO'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Titulo',
                errorText: _titleError,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _subtitleController,
              decoration: InputDecoration(
                labelText: 'Subtitulo',
                errorText: _subtitleError,
              ),
            ),
            SizedBox(height: 8.0),
            SizedBox(
              width: screenSize.width * 0.5,
              child: RaisedButton(
                child: Text(
                  widget.todo == null ? 'CREAR' : 'ACTUALIZAR',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  _create();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _create() {
    var title = _titleController.text.trim();
    var subtitle = _subtitleController.text.trim();

    bool hasError = false;

    if (title.isEmpty) {
      setState(() {
        _titleError = 'Debes ingresar un titulo';
      });
      hasError = true;
    }

    if (subtitle.isEmpty) {
      setState(() {
        _subtitleError = 'Debes ingresar un subtitlo';
      });
      hasError = true;
    }

    if (title.length < 2) {
      setState(() {
        _titleError = 'El titulo debe tener al menos 2 letras';
      });
      hasError = true;
    }

    if (!hasError) {
      String id;
      if (widget.todo == null) {
        id = Uuid().v4().replaceAll('-', '');
      } else {
        id = widget.todo.id;
      }
      var todo = Todo(title: title, subtitle: subtitle, id: id);
      Navigator.of(context).pop(todo);
    }
  }
}
