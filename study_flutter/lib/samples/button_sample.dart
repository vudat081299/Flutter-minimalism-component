import 'package:flutter/material.dart';

class ButtonSample extends StatelessWidget {
  const ButtonSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16.0),
        const Text(
          'Button Samples',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextButton Sample
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.2), // Background color for clarity
              ),
              child: const Text('TextButton'),
            ),
            const SizedBox(width: 16.0),
            // ElevatedButton Sample
            ElevatedButton(
              onPressed: () {},
              child: const Text('ElevatedButton'),
            ),
            const SizedBox(width: 16.0),
            // OutlinedButton Sample
            OutlinedButton(
              onPressed: () {},
              child: const Text('OutlinedButton'),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // IconButton Sample
            IconButton(
              icon: const Icon(Icons.thumb_up),
              onPressed: () {},
              color: Colors.blue,
            ),
            const SizedBox(width: 16.0),
            // ElevatedButton with Icon
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Icon Button'),
            ),
            const SizedBox(width: 16.0),
            // FloatingActionButton Sample
            FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.navigation),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}