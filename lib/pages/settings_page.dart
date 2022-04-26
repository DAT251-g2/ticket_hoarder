import 'package:flutter/material.dart';
//import '../main.dart';

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
            onChanged: (value) {
              setState(() {
                buss = value!;
              });
            },
            title: const Text(
              'Buss',
              style: TextStyle(fontSize: 10),
            ),
          ),
          CheckboxListTile(
            value: bybane,
            onChanged: (value) {
              setState(() {
                bybane = value!;
              });
            },
            title: const Text(
              'Bybane',
              style: TextStyle(fontSize: 10),
            ),
          ),
          CheckboxListTile(
            value: bysykkel,
            onChanged: (value) {
              setState(() {
                bysykkel = value!;
              });
            },
            title: const Text(
              'Bysykkel',
              style: TextStyle(fontSize: 10),
            ),
          ),
          CheckboxListTile(
            value: sparkesykkel,
            onChanged: (value) {
              setState(() {
                sparkesykkel = value!;
              });
            },
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
