import 'package:flutter/material.dart';

class PlaceholderSample extends StatelessWidget {
  const PlaceholderSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Placeholder Samples',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Simple Placeholder
            Container(
              width: 100,
              height: 100,
              child: const Placeholder(),
            ),
            const SizedBox(width: 16.0),
            // Placeholder with color and strokeWidth
            Container(
              width: 100,
              height: 100,
              child: const Placeholder(
                color: Colors.red, // Màu của đường viền
                strokeWidth: 5,   // Độ rộng của nét vẽ
              ),
            ),
            const SizedBox(width: 16.0),
            // Placeholder with fallback size
            Container(
              width: 150,
              height: 150,
              child: const Placeholder(
                color: Colors.blue,
                strokeWidth: 3,
                fallbackHeight: 50, // Chiều cao thay thế nếu không có kích thước xác định
                fallbackWidth: 50,  // Chiều rộng thay thế nếu không có kích thước xác định
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder with reduced strokeWidth
            Container(
              width: 100,
              height: 100,
              child: const Placeholder(
                strokeWidth: 2,
              ),
            ),
            const SizedBox(width: 16.0),
            // Placeholder in a rotated container
            Transform.rotate(
              angle: 0.25, // Quay 45 độ
              child: Container(
                width: 100,
                height: 100,
                child: const Placeholder(
                  color: Colors.green,
                  strokeWidth: 4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}