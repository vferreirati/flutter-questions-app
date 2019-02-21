import 'package:exata_questoes_app/pages/home/home_page.dart';
import 'package:exata_questoes_app/services/injector.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:flutter/material.dart';

void main() {
  setup();
  runApp(ExataApp());
}

class ExataApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Exata Questões",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[800],
        accentColor: Colors.pink,
      ),
      home: HomePage(homeBloc: kiwi.Container().resolve()),
    );
  }
}
