import 'package:flutter/material.dart';
import '../main.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ticket_hoarder/pages/my_home_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Column(
        children: [
          ElevatedButton(
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
          html
        ],
      ),
    );
  }
}

Widget html = Html(data: """
  <iframe
    title="Entur-widget"
    frameBorder="0"
    style="
    display:block;
    height:800px;
    width:100%;
    "
    src="https://widget.entur.no?"
></iframe>""");
