import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_flutter/components/minimalism_textfield.dart';
import 'package:study_flutter/models/ticket_manager.dart';
import 'components/minimalism_button.dart';
import 'components/minimalism_dialog.dart';
import 'package:flutter/services.dart';

class DetailAndEditTicket extends StatefulWidget {
  final Ticket ticket;
  final TicketManager ticketManager;
  final Function(Ticket) updateTicketAction;

  const DetailAndEditTicket({
    super.key,
    required this.ticket,
    required this.ticketManager,
    required this.updateTicketAction,
  });

  @override
  State<DetailAndEditTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<DetailAndEditTicket> {
  Set<int> selectedSegment = {0};
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final _correspondingType = ['spend', 'income'];

  DateTime? _selectedDate;
  final DateTime _firstDate = DateTime(DateTime.now().year - 2);
  final DateTime _lastDate = DateTime(DateTime.now().year + 1);

  int _selectedTypeIndex = 0;

  String formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return widget.ticket.date;
    }
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  void _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: _firstDate,
      lastDate: _lastDate,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final type = widget.ticket.type;
    int index = _correspondingType.indexOf(type);
    if (index != -1) {
      _selectedTypeIndex = index;
    }

    _labelController.text = widget.ticket.label;
    _descriptionController.text = widget.ticket.description;
    _amountController.text = widget.ticket.amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket detail'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTicketTypeChoiceChip(),
              const SizedBox(height: 16.0),
              MinimalismTextField(label: 'Ticket Label', controller: _labelController),
              const SizedBox(height: 16.0),
              MinimalismTextField(label: 'Description', controller: _descriptionController),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: MinimalismTextField(label: 'Amount', controller: _amountController, suffixText: 'VNĐ',
                        hintText: null, textInputType: TextInputType.number),
                  ),
                  const SizedBox(width: 8.0),
                  SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () => _selectDate(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        formatDate(_selectedDate),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      [String? suffixText, String? hintText, TextInputType? textInputType]) {
    const outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
      borderRadius: BorderRadius.zero,
    );
    return TextField(
      autofocus: true,
      controller: controller,
      decoration: InputDecoration(
        border: outlineInputBorder,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        suffixText: suffixText,
        suffixStyle: const TextStyle(color: Colors.grey),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
      ),
      style: const TextStyle(color: Colors.black),
      textInputAction: TextInputAction.next,
      keyboardType: textInputType ?? TextInputType.text,
      maxLines: 1,
    );
  }

  Widget _buildTicketTypeChoiceChip() {
    final isSelectedSpendChip = _selectedTypeIndex == 0;
    final isSelectedIncomeChip = _selectedTypeIndex == 1;
    return Row(
      children: [
        Wrap(
          children: [
            ChoiceChip(
              selectedColor: Colors.black,
              labelStyle: TextStyle(
                  color: isSelectedSpendChip ? Colors.white : Colors.black),
              checkmarkColor: isSelectedSpendChip ? Colors.white : Colors.black,
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              label: const Text('Spend'),
              selected: isSelectedSpendChip,
              onSelected: (value) {
                setState(() {
                  _selectedTypeIndex = value ? 0 : _selectedTypeIndex;
                });
              },
            ),
            const SizedBox(width: 8.0),
            ChoiceChip(
              selectedColor: Colors.black,
              labelStyle: TextStyle(
                  color: isSelectedIncomeChip ? Colors.white : Colors.black),
              checkmarkColor:
                  isSelectedIncomeChip ? Colors.white : Colors.black,
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              label: const Text('Income'),
              selected: isSelectedIncomeChip,
              onSelected: (value) {
                setState(() {
                  _selectedTypeIndex = value ? 1 : _selectedTypeIndex;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50.0,
            child: MinimalismButton(
              text: 'Update',
              action: () {
                final date = formatDate(_selectedDate ?? DateTime.now());
                final type = _correspondingType[_selectedTypeIndex];
                final label = _labelController.text;
                final description = _descriptionController.text;
                double? amount = double.tryParse(_amountController.text);
                if (amount != null) {
                  final ticket = Ticket(
                      widget.ticket.id, type, description, label, amount, date);
                  widget.updateTicketAction(ticket);
                  Navigator.popUntil(context, (route) => route.isFirst);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const MinimalismDialog();
                    },
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
