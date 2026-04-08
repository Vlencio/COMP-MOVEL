// Ex2: Mostrar mensagem quando a lista está vazia
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/task_tile.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<String> _tarefas = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  Future<void> _carregarTarefas() async {
    final prefs = await SharedPreferences.getInstance();
    final lista = prefs.getStringList('tarefas') ?? [];
    setState(() {
      _tarefas.addAll(lista);
    });
  }

  Future<void> _salvarTarefas() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tarefas', _tarefas);
  }

  void _adicionarTarefa() {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;
    setState(() {
      _tarefas.add(texto);
    });
    _salvarTarefas();
    _controller.clear();
  }

  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
    _salvarTarefas();
  }

  Future<void> _limparTudo() async {
    setState(() {
      _tarefas.clear();
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('tarefas');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        actions: [
          TextButton(
            onPressed: _limparTudo,
            child: const Text('Limpar tudo', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Nova tarefa',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _adicionarTarefa,
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _tarefas.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma tarefa ainda.\nAdicione uma acima!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _tarefas.length,
                    itemBuilder: (context, index) {
                      return TaskTile(
                        nome: _tarefas[index],
                        onRemover: () => _removerTarefa(index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
