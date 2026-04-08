import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lifecycle',
      home: const MensagemLifecycleScreen(),
    );
  }
}

class MensagemLifecycleScreen extends StatefulWidget {
  const MensagemLifecycleScreen({super.key});

  @override
  State<MensagemLifecycleScreen> createState() =>
      _MensagemLifecycleScreenState();
}

class _MensagemLifecycleScreenState extends State<MensagemLifecycleScreen> {
  bool mensagemVisivel = true;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('initState chamado');
  }

  @override
  void dispose() {
    _controller.dispose();
    print('dispose chamado');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build chamado');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lifecycle'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Digite uma mensagem',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            if (mensagemVisivel)
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.yellow[100],
                child: Text(
                  _controller.text.isEmpty
                      ? 'Mensagem aqui'
                      : _controller.text,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  mensagemVisivel = !mensagemVisivel;
                });
              },
              child: Text(mensagemVisivel ? 'Ocultar mensagem' : 'Mostrar mensagem'),
            ),
          ],
        ),
      ),
    );
  }
}
