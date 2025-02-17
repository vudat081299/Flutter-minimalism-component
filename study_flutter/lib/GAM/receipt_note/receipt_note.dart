import 'package:flutter/material.dart';
import 'package:study_flutter/GAM/receipt_note/widgets/components/navigation_title.dart';
import 'package:study_flutter/GAM/receipt_note/widgets/information_section.dart';

class ReceiptNote extends StatelessWidget {
  const ReceiptNote({
    super.key,
    this.receiptNoteId,
  });

  final String? receiptNoteId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavigationTitle(
          title: 'Phiếu nhập $receiptNoteId',
          backButton: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {},
          ),
        ),
        ListView(children: [
          // InformationSection()
        ]),
      ],
    );
  }
}
