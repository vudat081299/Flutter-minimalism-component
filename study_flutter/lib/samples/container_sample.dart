import 'package:flutter/material.dart';
import 'dart:math';

class ContainerSample extends StatelessWidget {
  const ContainerSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Container Samples',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Simple Container with background color and border
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(
                  color: Colors.black, // Viền đen
                  width: 2.0,          // Độ rộng của viền
                ),
                borderRadius: BorderRadius.circular(10), // Bo góc
              ),
              child: const Center(child: Text('Box 1')),
            ),
            const SizedBox(width: 16.0),
            // Rotated Container with shadow and gradient
            Transform.rotate(
              angle: pi / 4, // Quay container 45 độ
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.green, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5), // Bóng đổ
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(3, 3), // Hướng của bóng
                    ),
                  ],
                ),
                child: const Center(child: Text('Box 2')),
              ),
            ),
            const SizedBox(width: 16.0),
            // Container with image, border and rotation
            Transform.rotate(
              angle: -pi / 8, // Quay container -22.5 độ
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://via.placeholder.com/100'), // Placeholder image
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: const Center(child: Text('Box 3')),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}