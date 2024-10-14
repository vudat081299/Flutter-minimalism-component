import 'package:flutter/material.dart';
import 'package:study_flutter/components/ticket_list.dart';
import 'package:study_flutter/models/ticket_manager.dart';
import 'package:study_flutter/widget_samples.dart';

import 'components/theme_button.dart';
import '../add_ticket.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.appTitle,
    required this.changeTheme,
    required this.ticketManager,
  });

  final String appTitle;
  final void Function(bool useLightMode) changeTheme;
  final TicketManager ticketManager;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _nonameFunction() {}

  int tab = 0;
  List<NavigationDestination> appBarDestinations = const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      label: 'Explore',
      selectedIcon: Icon(Icons.home),
    ),
    NavigationDestination(
      icon: Icon(Icons.list_outlined),
      label: 'Orders',
      selectedIcon: Icon(Icons.list),
    ),
    NavigationDestination(
      icon: Icon(Icons.person_2_outlined),
      label: 'Account',
      selectedIcon: Icon(Icons.person),
    )
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      TicketList(
        tickets: tickets,
        didUpdate: () {
          setState(() {});
        },
        ticketManager: widget.ticketManager,
      ),
      const WidgetSamples(),
      const Center(
        child: Text(
          'Account Page',
          style: TextStyle(fontSize: 32.0),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle),
        elevation: 4.0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          ThemeButton(
            changeThemeMode: widget.changeTheme,
          ),
          ThemeButton(
            changeThemeMode: widget.changeTheme,
          ),
        ],
      ),
      body: IndexedStack(
        index: tab,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (index) {
          setState(() {
            tab = index;
          });
        },
        destinations: appBarDestinations,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddTicket(
                    ticketManager: widget.ticketManager,
                    addTicketAction: (ticket) {
                      setState(() {
                        widget.ticketManager.addTicket(ticket);
                      });
                      Navigator.popUntil(context, (route) => route.isFirst);
                    })),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
