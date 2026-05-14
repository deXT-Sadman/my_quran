import 'package:flutter/material.dart';

class SurahDetailScreen extends StatelessWidget {
  const SurahDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Surah Detail')),
      body: const Center(child: Text('Surah details will be shown here.')),
    );
  }
}
