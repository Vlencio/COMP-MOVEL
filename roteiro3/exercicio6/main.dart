import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Produtos',
      home: const ProdutosScreen(),
    );
  }
}

class ProdutosScreen extends StatelessWidget {
  const ProdutosScreen({super.key});

  final List<String> produtos = const [
    'Notebook',
    'Mouse',
    'Teclado',
    'Monitor',
    'Headset',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos')),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(produtos[index]));
        },
      ),
    );
  }
}
