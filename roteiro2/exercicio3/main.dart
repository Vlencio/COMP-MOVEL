import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navegação Ex3',
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

class Tela2 extends StatelessWidget {
  const Tela2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 10);
              },
              child: const Text('Retornar 10'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 20);
              },
              child: const Text('Retornar 20'),
            ),
          ],
        ),
      ),
    );
  }
}
