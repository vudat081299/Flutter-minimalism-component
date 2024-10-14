import 'package:flutter/material.dart';

class RowSample extends StatelessWidget {
  const RowSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều ngang
      crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa theo chiều dọc
      children: [
        const Text(
          'Row',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 16), // Khoảng cách giữa tiêu đề và hộp
        Container(
          width: 100,
          height: 100,
          color: Colors.red,
          child: Center(child: Text('Box 1')),
        ),
        SizedBox(width: 1), // Khoảng cách giữa các box
        Container(
          width: 100,
          height: 100,
          color: Colors.green,
          child: Center(child: Text('Box 2')),
        ),
        SizedBox(width: 1),
        Container(
          width: 100,
          height: 100,
          color: Colors.blue,
          child: Center(child: Text('Box 3')),
        ),
      ],
    );
  }
}