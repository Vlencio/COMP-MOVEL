import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navegação Ex4',
      home: const Tela1(),
    );
  }
}

class Tela1 extends StatefulWidget {
  const Tela1({super.key});

  @override
  State<Tela1> createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  int? valorRecebido;

  void _irParaTela2() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Tela2()),
    );

    if (resultado != null) {
      setState(() {
        valorRecebido = resultado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela 1')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (valorRecebido != null)
              Text(
                'Valor recebido: $valorRecebido',
                style: const TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _irParaTela2,
              child: const Text('Ir para Tela 2'),
            ),
          ],
        ),
      ),
    );
  }
}

class Tela2 extends StatefulWidget {
  const Tela2({super.key});

  @override
  State<Tela2> createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela 2')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite um número',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final numero = int.tryParse(_controller.text);
                Navigator.pop(context, numero);
              },
              child: const Text('Retornar número'),
            ),
          ],
        ),
      ),
    );
  }
}
