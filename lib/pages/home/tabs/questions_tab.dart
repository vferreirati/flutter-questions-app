import 'package:exata_questoes_app/widgets/gradient_button.dart';
import 'package:exata_questoes_app/widgets/multi_select_dropdown.dart';
import 'package:exata_questoes_app/widgets/single_select_dropdown.dart';
import 'package:flutter/material.dart';

class QuestionsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            _userAvatarBadge(),
            _questionFilters(),
            SizedBox(height: 15),
            _submitButton()
          ],
        ),
      ),
    );
  }

  Widget _userAvatarBadge() {
    return GestureDetector(
      onTap: _showUserProfile,
      child: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: EdgeInsets.only(top: 15, right: 15),
        child: Image.asset("assets/images/avatar-placeholder.png"),
      ),
    );
  }

  Widget _questionFilters() {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 8, right: 8),
      child: Card(
        child: Container(
          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              SingleSelectDropDown(
                title: "Simulados",
                itemsTitle: ["Enem 1", "Enem 2", "Enem 3", "Enem 4"],
                onSelect: (title) => print("O simulado escolhido foi $title"),
              ),
              Divider(),
              MultiSelectDropDown(
                title: "Matérias",
                itemsTitle: ["Português", "Matemática", "Física", "Química"],
                onSelect: (isChecked, title) => print("$title será buscado? $isChecked"),
              ),
              Divider(),
              MultiSelectDropDown(
                title: "Anos",
                itemsTitle: ["2018", "2017", "2016", "2015"],
                onSelect: (isChecked, title) => print("$title será buscado? $isChecked"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GradientButton(onClick: () => print("Clicked to start"), title: "Iniciar", isLoading: false)
    );
  }

  void _showUserProfile() {
    print("Pressed to show user profile!");
  }
}
