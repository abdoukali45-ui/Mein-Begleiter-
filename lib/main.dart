import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MeinBegleiterApp());
}

/// Root widget of the "Mein Begleiter" app.
///
/// V0.2: real Speech-to-Text listening is wired up. Still missing: a real
/// AI response (Claude API) and Text-to-Speech output. See README.md.
class MeinBegleiterApp extends StatelessWidget {
  const MeinBegleiterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mein Begleiter',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
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
                    'Gespräch beginnen',
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
              const SizedBox(height: 8),
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
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _speechReady = false;
  bool listening = false;
  String recognizedText = '';
  String statusMessage = 'Hallo! Wie geht es dir heute?';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    final micStatus = await Permission.microphone.request();
    if (!micStatus.isGranted) {
      setState(() {
        statusMessage = 'Bitte erlaube den Mikrofon-Zugriff in den Einstellungen.';
      });
      return;
    }
    _speechReady = await _speech.initialize(
      onStatus: (status) {
        if (status == 'notListening' && listening) {
          setState(() => listening = false);
        }
      },
      onError: (error) {
        setState(() {
          listening = false;
          statusMessage = 'Es gab ein Problem beim Zuhören. Versuch es noch einmal.';
        });
      },
    );
    setState(() {});
  }

  Future<void> _toggleListening() async {
    if (!_speechReady) {
      await _initSpeech();
      if (!_speechReady) return;
    }

    if (listening) {
      await _speech.stop();
      setState(() => listening = false);
      return;
    }

    setState(() {
      listening = true;
      recognizedText = '';
      statusMessage = 'Ich höre dir zu ...';
    });

    await _speech.listen(
      localeId: 'de_DE',
      onResult: (result) {
        setState(() {
          recognizedText = result.recognizedWords;
          if (result.finalResult) {
            listening = false;
            statusMessage = recognizedText.isEmpty
                ? 'Ich habe nichts verstanden. Versuch es noch einmal.'
                : 'Du hast gesagt: „$recognizedText“';
            // Nächster Schritt: recognizedText an die KI (Claude API) senden
            // und die Antwort per Text-to-Speech vorlesen.
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }

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
                  statusMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _toggleListening,
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
