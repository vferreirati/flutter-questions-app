import 'package:exata_questoes_app/pages/home/tabs/notifications_tab.dart';
import 'package:exata_questoes_app/pages/home/home_bloc.dart';
import 'package:exata_questoes_app/pages/home/tabs/questions_tab.dart';
import 'package:exata_questoes_app/pages/home/tabs/simulations_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final HomeBloc homeBloc;

  HomePage({@required this.homeBloc});
  
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  static const int _QUESTIONS = 0;
  static const int _SIMULATIONS = 1;
  static const int _NOTIFICATIONS = 2;

  HomeBloc get _homeBloc => widget.homeBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: tab,
        children: <Widget>[
          QuestionsTab(bloc: _homeBloc),
          SimulationsTab(bloc: _homeBloc),
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
          icon: Icon(Icons.laptop_chromebook),
          title: Text("Questões"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          title: Text("Simulados"),
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
    _homeBloc.dispose();
    super.dispose();
  }
}
