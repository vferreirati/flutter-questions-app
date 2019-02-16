import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Text(
              "Font test",
              style: TextStyle(fontFamily: "MavenPro", fontSize: 30),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
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
        ),
      ),
    );
  }

  void _onBottomNavigationSelect(int value) {
    print("Clicked on $value");
    setState(() {
      index = value;
    });
  }
}
