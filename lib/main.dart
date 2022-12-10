import 'package:devfest2022/ui/todo_list_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DevFest 2022 Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const TodoListHome(),
    );
  }
}
