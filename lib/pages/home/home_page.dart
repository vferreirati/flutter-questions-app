import 'package:exata_questoes_app/pages/home/tabs/notifications_tab.dart';
import 'package:exata_questoes_app/pages/home/tabs/question/question_bloc.dart';
import 'package:exata_questoes_app/pages/home/tabs/question/questions_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  static const int _QUESTIONS = 0;
  static const int _NOTIFICATIONS = 1;

  QuestionBloc _questionBloc;

  @override
  void initState() {
    super.initState();
    _questionBloc = QuestionBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: tab,
        children: <Widget>[
          QuestionsTab(bloc: _questionBloc),
          NotificationsTab()
        ],
      ),
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
    setState(() {
      tab = value;
    });
  }

  @override
  void dispose() {
    _questionBloc.dispose();
    super.dispose();
  }
}
