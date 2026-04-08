// Ex3: Persistir última página acessada (3 botões: Página A, B, C)
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
      title: 'Última Página',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _paginaAtual = 'A';

  @override
  void initState() {
    super.initState();
    _carregarUltimaPagina();
  }

  Future<void> _carregarUltimaPagina() async {
    final prefs = await SharedPreferences.getInstance();
    final pagina = prefs.getString('ultima_pagina') ?? 'A';
    setState(() {
      _paginaAtual = pagina;
    });
  }

  Future<void> _selecionarPagina(String pagina) async {
    setState(() {
      _paginaAtual = pagina;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ultima_pagina', pagina);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navegação com Persistência')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Página atual: $_paginaAtual',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['A', 'B', 'C'].map((pagina) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _paginaAtual == pagina
                        ? Colors.deepPurple
                        : null,
                    foregroundColor: _paginaAtual == pagina
                        ? Colors.white
                        : null,
                  ),
                  onPressed: () => _selecionarPagina(pagina),
                  child: Text('Página $pagina'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
