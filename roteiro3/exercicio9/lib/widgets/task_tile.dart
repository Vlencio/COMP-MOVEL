import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String nome;
  final VoidCallback onRemover;

  const TaskTile({super.key, required this.nome, required this.onRemover});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(nome),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: onRemover,
      ),
    );
  }
}
