import 'package:flutter/material.dart';

class ColumnSample extends StatelessWidget {
  const ColumnSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều dọc
      crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa theo chiều ngang
      children: [
        const Text(
          'Column',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: 100,
          height: 100,
          color: Colors.red,
          child: Center(child: Text('Box 1')),
        ),
        SizedBox(height: 1), // Khoảng cách giữa các box
        Container(
          width: 100,
          height: 100,
          color: Colors.green,
          child: Center(child: Text('Box 2')),
        ),
        SizedBox(height: 1),
        Container(
          width: 100,
          height: 100,
          color: Colors.blue,
          child: Center(child: Text('Box 3')),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}