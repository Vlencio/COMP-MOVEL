import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Exercicio1 extends StatefulWidget {
  const Exercicio1({super.key});

  @override
  State<Exercicio1> createState() => _Exercicio1State();
}

class _Exercicio1State extends State<Exercicio1> {
  bool _ativo = false; // 1. estado

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 150),
            width: 200,
            height: _ativo ? 200 : 400,
            color: _ativo ? Colors.orange : Colors.purple,
          ),

          SizedBox(height: 24),

          // 3. botão que muda o estado
          ElevatedButton(
            onPressed: () => setState(() => _ativo = !_ativo),
            child: Text('Animar'),
          ),
        ],
      ),
    );
  }
}

class Exercicio2 extends StatefulWidget {
  const Exercicio2({super.key});

  @override
  State<Exercicio2> createState() => _Exercicio2State();
}

class _Exercicio2State extends State<Exercicio2> {
  bool _grande = false; // 1. estado

  void _animar() async {
    setState(() => _grande = true);
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => _grande = false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 100),
            width: 200,
            height: _grande ? 200 : 400,
            color: _grande ? Colors.orange : Colors.purple,
          ),

          SizedBox(height: 24),

          // 3. botão que muda o estado
          ElevatedButton(onPressed: _animar, child: Text('Animar')),
        ],
      ),
    );
  }
}

class Exercicio3 extends StatefulWidget {
  const Exercicio3({super.key});

  @override
  State<Exercicio3> createState() => _Exercicio3State();
}

class _Exercicio3State extends State<Exercicio3> {
  bool _visivel = true; // 1. estado

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _visivel ? 1.0 : 0.0,
            child: const Text('Ooooi'),
          ),

          SizedBox(height: 24),

          // 3. botão que muda o estado
          ElevatedButton(
            onPressed: () => setState(() => _visivel = !_visivel),
            child: Text('Esconder/Aparecer'),
          ),
        ],
      ),
    );
  }
}

class Exercicio4 extends StatefulWidget {
  const Exercicio4({super.key});

  @override
  State<Exercicio4> createState() => _Exercicio4State();
}

class _Exercicio4State extends State<Exercicio4> {
  bool _animar = true; // 1. estado

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            width: _animar ? 200 : 400,
            height: _animar ? 200 : 400,
            color: Colors.lightBlueAccent,
          ),

          SizedBox(height: 24),

          // 3. botão que muda o estado
          ElevatedButton(
            onPressed: () => setState(() => _animar = !_animar),
            child: Text('Animar'),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4, // quantidade de abas
        child: Scaffold(
          appBar: AppBar(
            title: Text('Exercícios'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Exec 1'),
                Tab(text: 'Exec 2'),
                Tab(text: 'Exec 3'),
                Tab(text: 'Exec 4'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // conteúdo de cada aba, na mesma ordem
              Center(child: Exercicio1()),
              Center(child: Exercicio2()),
              Center(child: Exercicio3()),
              Center(child: Exercicio4()),
            ],
          ),
        ),
      ),
    );
  }
}
