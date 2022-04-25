import 'package:flutter/material.dart';
//import '../main.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ticket_hoarder/pages/my_home_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  bool buss = false;
  bool bybane = false;
  bool bysykkel = false;
  bool sparkesykkel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Innstillinger'),
      ),
      body: Column(
        children: [
          CheckboxListTile(
            value: buss,
            onChanged: (buss) => this.buss = buss!,
            title: const Text(
              'Buss',
              style: TextStyle(fontSize: 10),
            ),
          ),
          CheckboxListTile(
            value: bybane,
            onChanged: (bybane) => this.bybane = bybane!,
            title: const Text(
              'Bybane',
              style: TextStyle(fontSize: 10),
            ),
          ),
          CheckboxListTile(
            value: bysykkel,
            onChanged: (bysykkel) => this.bysykkel = bysykkel!,
            title: const Text(
              'Bysykkel',
              style: TextStyle(fontSize: 10),
            ),
          ),
          CheckboxListTile(
            value: sparkesykkel,
            onChanged: (sparkesykkel) => this.sparkesykkel = sparkesykkel!,
            title: const Text(
              'Sparkesykkel',
              style: TextStyle(fontSize: 10),
            ),
          )
        ],
      ),
    );
  }
}
