import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_flutter/models/ticket_manager.dart';

class AddTicket extends StatefulWidget {
  final TicketManager ticketManager;
  final Function(Ticket) addTicketAction;

  const AddTicket({
    super.key,
    required this.ticketManager,
    required this.addTicketAction,
  });

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  Set<int> selectedSegment = {0};
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final correspondingType = ['spend', 'income'];

  DateTime? selectedDate;
  final DateTime _firstDate = DateTime(DateTime.now().year - 2);
  final DateTime _lastDate = DateTime(DateTime.now().year + 1);

  String formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Select Date';
    }
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  void _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: _firstDate,
      lastDate: _lastDate,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add ticket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTicketSegmentedType(),
            const SizedBox(height: 8.0),
            _buildTextField('Ticket Label', _labelController),
            const SizedBox(height: 8.0),
            _buildTextField('Description', _descriptionController),
            const SizedBox(height: 8.0),
            _buildTextField('Amount', _amountController),
            const SizedBox(height: 16.0),
            TextButton(
              child: Text(formatDate(selectedDate)),
              onPressed: () => _selectDate(context),
            ),
            const SizedBox(height: 8.0),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  Widget _buildTicketSegmentedType() {
    return SegmentedButton(
      showSelectedIcon: false,
      segments: const [
        ButtonSegment(
          value: 0,
          label: Text('Spend'),
          icon: Icon(Icons.shopping_cart),
        ),
        ButtonSegment(
          value: 1,
          label: Text('Income'),
          icon: Icon(Icons.paid),
        ),
      ],
      selected: selectedSegment,
      onSelectionChanged: _onSegmentSelected,
    );
  }

  void _onSegmentSelected(Set<int> segmentIndex) {
    setState(() {
      selectedSegment = segmentIndex;
    });
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        final date = formatDate(selectedDate ?? DateTime.now());
        final type = correspondingType[selectedSegment.first];
        final label = _labelController.text;
        final description = _descriptionController.text;
        double? amount = double.tryParse(_amountController.text);
        if (amount != null) {
          final ticket = Ticket(widget.ticketManager.nextId.toString(), type,
              description, label, amount, date);
          widget.addTicketAction(ticket);
        }
      },
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Add ticket'),
      ),
    );
  }
}
