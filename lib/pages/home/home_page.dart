import 'package:exata_questoes_app/pages/home/tabs/notifications_tab.dart';
import 'package:exata_questoes_app/pages/home/tabs/questions_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  static const int _QUESTIONS = 0;
  static const int _NOTIFICATIONS = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tab == _QUESTIONS
          ? QuestionsTab()
          : NotificationsTab(), // TODO:  Animate the transition between tabs
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: tab,
      fixedColor: Theme.of(context).accentColor,
      onTap: _onBottomNavigationSelect,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          title: Text("Questões"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          title: Text("Notificações"),
        )
      ],
    );
  }

  void _onBottomNavigationSelect(int value) {
    if (value == tab) return;

    print(value);
    setState(() {
      tab = value;
    });
  }
}
