import 'package:flutter/material.dart';
import 'package:ticket_hoarder/pages/my_home_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: 'Ticket Hoarder',
                        )));
            // Navigate back to first route when tapped.
          },
          child: const Text('Nothing here yet'),
        ),
      ),
    );
  }
}
