import 'package:exata_questoes_app/pages/home/home_page.dart';
import 'package:exata_questoes_app/pages/home/home_bloc.dart';
import 'package:flutter/material.dart';

void main() => runApp(ExataApp());

class ExataApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[800],
        accentColor: Colors.pink,
      ),
      home: HomePage(homeBloc: HomeBloc()),
    );
  }
}
