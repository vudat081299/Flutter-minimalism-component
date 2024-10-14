import 'package:flutter/material.dart';

class StackSample extends StatelessWidget {
  const StackSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Stack',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            // View 1: Nền lớn nhất
            Container(
              width: 300,
              height: 300,
              color: Colors.blue,
            ),
            // View 2: Nền trung bình
            Container(
              width: 200,
              height: 200,
              color: Colors.red,
            ),
            // View 3: Nền nhỏ nhất
            Container(
              width: 100,
              height: 100,
              color: Colors.green,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
