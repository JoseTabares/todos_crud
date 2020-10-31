import 'package:flutter/material.dart';

class Todo {
  String title;
  String subtitle;
  String id;

  Todo({
    @required this.title,
    @required this.subtitle,
    this.id,
  });
}
