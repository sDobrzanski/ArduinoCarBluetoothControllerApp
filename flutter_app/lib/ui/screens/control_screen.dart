import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:routemaster/routemaster.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({super.key});

  static const String route = '/control';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            iconSize: 24,
            icon: const Icon(Ionicons.arrow_back),
            onPressed: () => Routemaster.of(context).history.back()),
      ),
      body: const Center(child: Text('Control screen')),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
