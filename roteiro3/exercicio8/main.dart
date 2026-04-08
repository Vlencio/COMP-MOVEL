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
          return ProductTile(nome: produtos[index]);
        },
      ),
    );
  }
}

// ProductTile melhorado: ícone à esquerda, subtitle, seta à direita
class ProductTile extends StatelessWidget {
  final String nome;

  const ProductTile({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.shopping_bag),
      title: Text(nome),
      subtitle: const Text('Produto disponível'),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
