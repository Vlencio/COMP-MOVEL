// Ex5: Carrinho simples com persistência (Produto A, B, C)
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrinho',
      home: const CarrinhoScreen(),
    );
  }
}

class CarrinhoScreen extends StatefulWidget {
  const CarrinhoScreen({super.key});

  @override
  State<CarrinhoScreen> createState() => _CarrinhoScreenState();
}

class _CarrinhoScreenState extends State<CarrinhoScreen> {
  final List<String> _produtos = ['Produto A', 'Produto B', 'Produto C'];
  List<String> _carrinho = [];

  @override
  void initState() {
    super.initState();
    _carregarCarrinho();
  }

  Future<void> _carregarCarrinho() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _carrinho = prefs.getStringList('carrinho') ?? [];
    });
  }

  Future<void> _adicionarAoCarrinho(String produto) async {
    setState(() {
      _carrinho.add(produto);
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('carrinho', _carrinho);
  }

  Future<void> _limparCarrinho() async {
    setState(() {
      _carrinho.clear();
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('carrinho');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        actions: [
          TextButton(
            onPressed: _limparCarrinho,
            child: const Text('Limpar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Produtos disponíveis:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ..._produtos.map((produto) => ListTile(
            title: Text(produto),
            trailing: ElevatedButton(
              onPressed: () => _adicionarAoCarrinho(produto),
              child: const Text('Adicionar ao carrinho'),
            ),
          )),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Carrinho:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('${_carrinho.length} item(s)', style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          if (_carrinho.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Carrinho vazio.', style: TextStyle(color: Colors.grey)),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _carrinho.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: Text(_carrinho[index]),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
