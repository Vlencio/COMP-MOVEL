// Ex7: Carregar automaticamente Pokémon inicial no initState()
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

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
  final AudioPlayer _audioPlayer = AudioPlayer();
  String nome = '';
  int numero = 0;
  String imagemUrl = '';
  String somUrl = '';
  bool carregando = false;
  String erro = '';

  @override
  void initState() {
    super.initState();
    buscarPokemon('25'); // Carrega Pikachu ao abrir
  }

  Future<void> buscarPokemon(String termo) async {
    if (termo.isEmpty) return;
    setState(() {
      carregando = true;
      erro = '';
    });

    try {
      final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/${termo.toLowerCase()}');
      final response = await http.get(url);

      if (response.statusCode != 200) {
        setState(() {
          erro = 'Pokémon "$termo" não encontrado.';
          nome = '';
          imagemUrl = '';
          somUrl = '';
          carregando = false;
        });
        return;
      }

      final dados = jsonDecode(response.body);

      setState(() {
        nome = dados['name'];
        numero = dados['id'];
        imagemUrl = dados['sprites']['other']['official-artwork']['front_default'] ?? '';
        somUrl = dados['cries']?['latest'] ?? '';
        carregando = false;
      });
    } catch (e) {
      setState(() {
        erro = 'Erro de conexão.';
        carregando = false;
      });
    }
  }

  Future<void> tocarSom() async {
    if (somUrl.isEmpty) return;
    await _audioPlayer.play(UrlSource(somUrl));
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
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
            if (erro.isNotEmpty)
              Text(erro, style: const TextStyle(color: Colors.red, fontSize: 16)),
            if (imagemUrl.isNotEmpty) Image.network(imagemUrl, height: 200),
            if (nome.isNotEmpty) ...[
              Text('#$numero', style: const TextStyle(fontSize: 18, color: Colors.grey)),
              Text(nome, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              if (somUrl.isNotEmpty)
                ElevatedButton.icon(
                  onPressed: tocarSom,
                  icon: const Icon(Icons.volume_up),
                  label: const Text('Ouvir som'),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
