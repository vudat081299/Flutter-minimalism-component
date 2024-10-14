import 'package:flutter/material.dart';

enum TicketType {
  income('income', Icons.paid),
  spend('spend', Icons.shopping_cart);

  const TicketType(this.label, this.icon);
  final String label;
  final IconData icon;
}

class Ticket {
  final Map<String, IconData> iconMap = {
    'error': Icons.error,
    'income': Icons.paid,
    'spend': Icons.shopping_cart,
  };

  String id;
  String type;
  String label;
  String description;
  double amount;
  String date;

  Ticket(
    this.id,
    this.type,
    this.description,
    this.label,
    this.amount,
    this.date,
  );

  IconData iconData() {
    if (type == 'income') {
      return TicketType.income.icon;
    } else if (type == 'spend') {
      return TicketType.spend.icon;
    }
    return Icons.error;
  }
}

List<Ticket> tickets = [
  Ticket(
    '0',
    'spend',
    '',
    'Shopping at Mall',
    300000.0,
    '10/09/2024',
  ),
  Ticket(
    '1',
    'income',
    '',
    'Monthly income',
    100000000.0,
    '13/09/2024',
  ),
  Ticket(
    '1',
    'spend',
    '',
    'Breakfast at Mc',
    80000.0,
    '14/09/2024',
  ),
  Ticket(
    '1',
    'spend',
    '',
    'Func raising',
    200000.0,
    '14/09/2024',
  ),
  Ticket(
    '1',
    'spend',
    '',
    'Football fund',
    100000000.0,
    '13/09/2024',
  ),
  Ticket(
    '1',
    'spend',
    '',
    'Office fine',
    140000.0,
    '07/10/2024',
  ),
  Ticket(
    '1',
    'spend',
    '',
    'Football fund',
    100000000.0,
    '13/09/2024',
  ),
  Ticket(
    '1',
    'spend',
    '',
    'Office fine',
    140000.0,
    '07/10/2024',
  ),
  Ticket(
    '1',
    'spend',
    '',
    'Football fund',
    100000000.0,
    '13/09/2024',
  ),
  Ticket(
    '1',
    'spend',
    '',
    'Office fine',
    140000.0,
    '07/10/2024',
  ),
  Ticket(
    '1',
    'spend',
    '',
    'Football fund',
    100000000.0,
    '13/09/2024',
  ),
  Ticket(
    '1',
    'spend',
    '',
    'Office fine',
    140000.0,
    '07/10/2024',
  ),
];

enum DeliveryMode { delivery, pickup }

class TicketManager {
  final List<Ticket> _tickets = [
    Ticket(
      '0',
      'spend',
      '',
      'Ghopping at Mall',
      30.0,
      '10/09/2024',
    ),
    Ticket(
      '1',
      'income',
      '',
      'Monthly income',
      100.0,
      '13/09/2024',
    ),
    Ticket(
      '2',
      'spend',
      '',
      'Breakfast at Mc',
      8.0,
      '14/09/2024',
    ),
    Ticket(
      '3',
      'spend',
      '',
      'Func raising',
      20.0,
      '14/09/2024',
    ),
    Ticket(
      '4',
      'income',
      '',
      'Football fund',
      10.0,
      '13/09/2024',
    ),
    Ticket(
      '5',
      'spend',
      '',
      'Office fine',
      14.0,
      '07/10/2024',
    ),
    Ticket(
      '6',
      'income',
      '',
      'Football fund',
      10.0,
      '13/09/2024',
    ),
    Ticket(
      '7',
      'spend',
      '',
      'Office fine',
      14.0,
      '07/10/2024',
    ),
    Ticket(
      '8',
      'spend',
      '',
      'Football fund',
      10.0,
      '13/09/2024',
    ),
    Ticket(
      '9',
      'spend',
      '',
      'Office fine',
      14.0,
      '07/10/2024',
    ),
    Ticket(
      '10',
      'spend',
      '',
      'Football fund',
      10.0,
      '13/09/2024',
    ),
    Ticket(
      '11',
      'spend',
      '',
      'Office fine',
      14.0,
      '07/10/2024',
    ),
  ];

  void addTicket(Ticket ticket) {
    _tickets.add(ticket);
  }

  void removeTicket(String id) {
    _tickets.removeWhere((ticket) => ticket.id == id);
  }

  void removeAll() {
    _tickets.clear();
  }

  Ticket ticketAt(int index) {
    if (index >= 0 && index < _tickets.length) {
      return _tickets[index];
    } else {
      throw IndexError.withLength(index, _tickets.length);
    }
  }

  void updateTicket(Ticket ticket) {
    int index = tickets.indexWhere((element) => element.id == ticket.id);
    _tickets[index] = ticket;
  }

  List<Ticket> get tickets => List.unmodifiable(_tickets);

  bool get isEmpty => _tickets.isEmpty;

  int get nextId => () {
    return int.parse(_tickets.last.id) + 1;
  }();
}
