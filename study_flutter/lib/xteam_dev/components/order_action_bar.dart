import 'package:flutter/material.dart';

class OrderActionBar extends StatelessWidget {
  const OrderActionBar({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 0.2, height: 0.2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            children: [
              ...buildUI(),
            ],
          ),
        ),
        const Divider(thickness: 2, height: 2),
      ],
    );
  }

  List<Widget> buildUI() {
    final List<Widget> result = [];
    final divider = Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 2,
        height: 20,
        color: Colors.green.shade300,
      ),
    );

    for (int i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length - 1) {
        result.add(divider);
      }
    }

    return result;
  }
}
