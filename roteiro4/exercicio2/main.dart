// Ex2: Mostrar nome e número do Pokémon retornado
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
  String nome = '';
  int numero = 0;
  bool carregando = false;

  Future<void> buscarPokemon() async {
    setState(() => carregando = true);

    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/1');
    final response = await http.get(url);
    final dados = jsonDecode(response.body);

    setState(() {
      nome = dados['name'];
      numero = dados['id'];
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (carregando) const CircularProgressIndicator(),
            if (nome.isNotEmpty) ...[
              Text('#$numero', style: const TextStyle(fontSize: 18, color: Colors.grey)),
              Text(nome, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: buscarPokemon,
              child: const Text('Buscar Pokémon #1'),
            ),
          ],
        ),
      ),
    );
  }
}
