// Ex1: Adicionar botão "Limpar tudo" na lista de tarefas com SharedPreferences
import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      home: const TaskListScreen(),
    );
  }
}
