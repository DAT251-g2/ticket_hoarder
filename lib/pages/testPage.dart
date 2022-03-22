import 'package:flutter/material.dart';
import '../main.dart';
import 'package:ticket_hoarder/pages/my_home_page.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_js/flutter_js.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPage createState() => _TestPage();
}

class _TestPage extends State<TestPage> {
  @override
  void initState() {
    super.initState();

    JavascriptRuntime flutterJS = getJavascriptRuntime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page for testing features'),
      ),
      body: const Center(
        child: Text('Entur JS testing'),
      ),
    );
  }
}
