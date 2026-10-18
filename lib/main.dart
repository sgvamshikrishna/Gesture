import 'package:flutter/material.dart';

void main() => runApp(const GestureApp());

class GestureApp extends StatelessWidget {
  const GestureApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Gestures',
    theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
    home: const GestureScreen(),
  );
}

class GestureScreen extends StatefulWidget {
  const GestureScreen({super.key});

  @override
  State<GestureScreen> createState() => _GestureScreenState();
}

class _GestureScreenState extends State<GestureScreen> {
  int taps = 0;
  bool isGreen = false;
  String message = 'Try tapping or holding below.';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Simple Gestures')),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Taps: $taps',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() {
                taps++;
                message = 'You tapped the button!';
              }),
              child: const Text('Tap me'),
            ),
            const SizedBox(height: 24),
            Semantics(
              button: true,
              label: 'Long press to change color',
              child: GestureDetector(
                onLongPress: () => setState(() {
                  isGreen = !isGreen;
                  message =
                      'Long press! Color changed to ${isGreen ? 'green' : 'blue'}.';
                }),
                child: Container(
                  width: 240,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: isGreen ? Colors.green : Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Long press me',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Semantics(
              liveRegion: true,
              child: Text(message, textAlign: TextAlign.center),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => setState(() {
                taps = 0;
                isGreen = false;
                message = 'Try tapping or holding below.';
              }),
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    ),
  );
}
