import 'package:flutter/material.dart';
import 'package:study_flutter/detail_and_edit_ticket.dart';
import '../components/simple_ticket.dart';
import '../../models/ticket_manager.dart';

class TicketList extends StatefulWidget {
  final List<Ticket> tickets;
  final Function() didUpdate;
  final TicketManager ticketManager;

  const TicketList({
    super.key,
    required this.tickets,
    required this.didUpdate,
    required this.ticketManager,
  });

  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  Ticket? _editedTicket;  
  bool _isHighlightRow = false;

  void _animateBackground() {
    setState(() {
      _isHighlightRow = true;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _isHighlightRow = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final length = widget.ticketManager.tickets.length + 1;
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ListView.builder(
        itemCount: length,
        itemBuilder: (context, index) {
          if (index == length - 1) {
            return Container(
              height: 100,
              color: backgroundColor,
            );
          } else {
            final ticket = widget.ticketManager.ticketAt(index);
            return Dismissible(
              key: Key(ticket.id),
              direction: DismissDirection.endToStart,
              background: Container(),
              secondaryBackground: const SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.delete_outline, color: Colors.redAccent),
                    SizedBox(width: 16.0),
                  ],
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  widget.ticketManager.removeTicket(ticket.id);
                });
                widget.didUpdate();
              },
              child: InkWell(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: (_isHighlightRow && (_editedTicket?.id == ticket.id))
                      ? const Color.fromARGB(255, 229, 229, 229)
                      : backgroundColor,
                  child: SimpleTicket(
                    amount: ticket.amount,
                    icon: ticket.iconData(),
                    intendedUse: ticket.label,
                    date: ticket.date,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailAndEditTicket(
                        ticket: ticket,
                        ticketManager: widget.ticketManager,
                        updateTicketAction: (ticket) {
                          _editedTicket = ticket;
                          _animateBackground();
                          setState(() {
                            widget.ticketManager.updateTicket(ticket);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
