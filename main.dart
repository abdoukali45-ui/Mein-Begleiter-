import 'package:flutter/material.dart';

void main() {
  runApp(const MeinBegleiterApp());
}

class MeinBegleiterApp extends StatelessWidget {
  const MeinBegleiterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mein Begleiter',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'sans',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 20),
          bodyMedium: TextStyle(fontSize: 18),
          titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mein Begleiter'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Guten Morgen! 👋',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Ich bin dein digitaler Gesprächspartner.',
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ConversationPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.mic, size: 36),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 22),
                  child: Text(
                    'Mit mir sprechen',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.favorite, size: 28),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Meine Interessen',
                    style: TextStyle(fontSize: 21),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.settings, size: 28),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Einstellungen',
                    style: TextStyle(fontSize: 21),
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                'Hinweis: Dieser Begleiter ist eine künstliche Intelligenz und kein Mensch.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  bool listening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gespräch'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 55,
                child: Icon(Icons.person, size: 60),
              ),
              const SizedBox(height: 18),
              const Text(
                'Anna',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Deine digitale Gesprächspartnerin',
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(),
                ),
                child: Text(
                  listening
                      ? 'Ich höre dir zu ...'
                      : 'Hallo! Wie geht es dir heute?',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() => listening = !listening);
                },
                child: CircleAvatar(
                  radius: 55,
                  child: Icon(
                    listening ? Icons.stop : Icons.mic,
                    size: 55,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                listening ? 'Tippe zum Beenden' : 'Tippe zum Sprechen',
                style: const TextStyle(fontSize: 19),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
