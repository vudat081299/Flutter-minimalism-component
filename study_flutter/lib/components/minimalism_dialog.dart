import 'package:flutter/material.dart';
import 'package:study_flutter/components/minimalism_button.dart';

class MinimalismDialog extends StatefulWidget {
  const MinimalismDialog({
    super.key,
  });

  @override
  State<MinimalismDialog> createState() => _MinimalismDialogState();
}

class _MinimalismDialogState extends State<MinimalismDialog> {
  @override
  Widget build(BuildContext context) {
    bool isBright = Theme.of(context).brightness == Brightness.light;
    final textColor = isBright ? Colors.black : Colors.white;
    final screenWidth = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: textColor, width: 1),
        borderRadius: BorderRadius.circular(0),
      ),
      child: SizedBox(
        width: screenWidth * 0.5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Error occur',
                  style: TextStyle(fontSize: 20, color: textColor)),
              const SizedBox(height: 16),
              Text('The amount should be numeric!',
                  style: TextStyle(color: textColor)),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomRight,
                child: MinimalismButton(
                  text: 'OK',
                  action: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // return AlertDialog(
    //   title: const Text('Error occur'),
    //   content: const Text('The amount should be numeric!'),
    //   actions: [
    //     TextButton(
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //       },
    //       child: const Text('OK'),
    //     ),
    //   ],
    // );
  }
}
