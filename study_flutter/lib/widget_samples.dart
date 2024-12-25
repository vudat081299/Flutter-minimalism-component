import 'package:flutter/material.dart';
import 'package:study_flutter/samples/button_sample.dart';
import 'package:study_flutter/samples/column_sample.dart';
import 'package:study_flutter/samples/container_sample.dart';
import 'package:study_flutter/samples/placeholder_sample.dart';
import 'package:study_flutter/samples/row_sample.dart';
import 'package:study_flutter/samples/stack_sample.dart';

class WidgetSamples extends StatelessWidget {
  const WidgetSamples({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        // StackSample(),
        // ColumnSample(),
        // RowSample(),
        // ButtonSample(),
        // ContainerSample(),
        // PlaceholderSample(),
      ],
    );
  }
}

// Test pull --rebase