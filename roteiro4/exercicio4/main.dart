// Ex4: Adicionar campo de texto para buscar por nome ou número
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      home: const PokedexScreen(),
    );
  }
}

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  final TextEditingController _controller = TextEditingController();
  String nome = '';
  int numero = 0;
  String imagemUrl = '';
  bool carregando = false;

  Future<void> buscarPokemon(String termo) async {
    if (termo.isEmpty) return;
    setState(() => carregando = true);

    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/${termo.toLowerCase()}');
    final response = await http.get(url);
    final dados = jsonDecode(response.body);

    setState(() {
      nome = dados['name'];
      numero = dados['id'];
      imagemUrl = dados['sprites']['other']['official-artwork']['front_default'] ?? '';
      carregando = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Nome ou número do Pokémon',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => buscarPokemon(_controller.text),
                  child: const Text('Buscar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (carregando) const CircularProgressIndicator(),
            if (imagemUrl.isNotEmpty) Image.network(imagemUrl, height: 200),
            if (nome.isNotEmpty) ...[
              Text('#$numero', style: const TextStyle(fontSize: 18, color: Colors.grey)),
              Text(nome, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            ],
          ],
        ),
      ),
    );
  }
}
