import 'package:flutter/material.dart';
import 'package:vallente_exam/todo.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.yellow,
    ),
    home: const Home(),
  )
  );
}