import 'package:flutter/material.dart';

class SimpleTicket extends StatelessWidget {
  final IconData icon;
  final String intendedUse;
  final String date;
  final double amount;

  const SimpleTicket({
    super.key,
    required this.amount,
    required this.icon,
    required this.intendedUse,
    required this.date,
  });

  void iconButtonAction() {}

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    bool isLightMode = Theme.of(context).brightness == Brightness.light;
    return SizedBox(
      height: 80.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(width: 16.0),
            Container(
              color: Colors.transparent,
              child: Material(
                color: isLightMode ? Colors.black : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  splashColor: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  onTap: iconButtonAction,
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(
                      icon,
                      color: isLightMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  intendedUse,
                  style: textTheme.bodyLarge?.copyWith(
                      color: const Color.fromARGB(255, 95, 95, 95),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                Text(
                  date,
                  style: textTheme.labelMedium?.copyWith(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            Text(amount.toStringAsFixed(2),
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(width: 16.0),
          ],
        ),
      ),
    );
  }
}
