import 'package:flutter/material.dart';

void main() => runApp(const NavigationApp());

class NavigationApp extends StatelessWidget {
  const NavigationApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Navigation',
    theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
    home: const HomeScreen(),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String sessionName = 'My navigation session';

  Future<void> openSummary() async {
    final name = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => SessionScreen(sessionName: sessionName),
      ),
    );
    if (!mounted || name == null) return;
    setState(() => sessionName = name);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('1. Navigation')),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(sessionName, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            const Icon(Icons.layers_outlined, size: 72, color: Colors.blue),
            const SizedBox(height: 24),
            const Text(
              'Explore three screens with Navigation.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Open your session summary, rename your session, and return home '
              'to see the updated name.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: openSummary,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('View session summary'),
            ),
          ],
        ),
      ),
    ),
  );
}

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key, required this.sessionName});

  final String sessionName;

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  late String name = widget.sessionName;

  Future<void> editName() async {
    final updatedName = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => RenameScreen(sessionName: name)),
    );
    if (!mounted || updatedName == null) return;
    setState(() => name = updatedName);
  }

  @override
  Widget build(BuildContext context) => PopScope<String>(
    canPop: false,
    onPopInvokedWithResult: (didPop, result) {
      if (!didPop) Navigator.pop(context, name);
    },
    child: Scaffold(
      appBar: AppBar(title: const Text('2. Session summary')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(name, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          const Text('This session name was passed from the home screen.'),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: editName,
            icon: const Icon(Icons.edit),
            label: const Text('Rename session'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => Navigator.pop(context, name),
            child: const Text('Back to home'),
          ),
        ],
      ),
    ),
  );
}

class RenameScreen extends StatefulWidget {
  const RenameScreen({super.key, required this.sessionName});

  final String sessionName;

  @override
  State<RenameScreen> createState() => _RenameScreenState();
}

class _RenameScreenState extends State<RenameScreen> {
  final formKey = GlobalKey<FormState>();
  late final controller = TextEditingController(text: widget.sessionName);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void save() {
    if (formKey.currentState!.validate()) {
      Navigator.pop(context, controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('3. Rename session')),
    body: Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextFormField(
            controller: controller,
            maxLength: 40,
            decoration: const InputDecoration(labelText: 'Session name'),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => save(),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Enter a session name.'
                : null,
          ),
          const SizedBox(height: 24),
          FilledButton(onPressed: save, child: const Text('Save name')),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel and go back'),
          ),
        ],
      ),
    ),
  );
}
