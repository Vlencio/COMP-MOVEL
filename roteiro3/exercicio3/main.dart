import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TitleText Widget',
      home: Scaffold(
        appBar: AppBar(title: const Text('Exemplo TitleText')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleText(texto: 'Bem-vindo ao App'),
              SizedBox(height: 20),
              TitleText(texto: 'Outro título grande'),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget reutilizável que recebe uma string e exibe como texto grande
class TitleText extends StatelessWidget {
  final String texto;

  const TitleText({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    );
  }
}
