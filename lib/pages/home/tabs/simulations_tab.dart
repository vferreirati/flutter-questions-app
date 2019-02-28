import 'package:exata_questoes_app/pages/home/home_bloc.dart';
import 'package:flutter/material.dart';

class SimulationsTab extends StatelessWidget {
  final HomeBloc bloc;

  SimulationsTab({this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildSearchBar(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Pesquise um simulado",
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none
          )
        ),
      ),
    );
  }
}
