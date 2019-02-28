import 'package:exata_questoes_app/models/api/materia_model.dart';
import 'package:exata_questoes_app/pages/home/home_bloc.dart';
import 'package:exata_questoes_app/widgets/gradient_button.dart';
import 'package:exata_questoes_app/widgets/multi_select_dropdown.dart';
import 'package:flutter/material.dart';

class QuestionsTab extends StatelessWidget {
  final HomeBloc bloc;

  QuestionsTab({this.bloc});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              _userAvatarBadge(),
              _questionFilters(context),
              SizedBox(height: 15),
              _submitButton(context)
            ],
          ),
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

  Widget _questionFilters(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 8, right: 8),
      child: Card(
        child: Container(
          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              _materiaFilter(),
              Divider(),
              _anoFilter()
            ],
          ),
        ),
      ),
    );
  }

  Widget _materiaFilter() {
    return StreamBuilder<bool>(
      stream: bloc.loadingMaterias,
      initialData: true,
      builder: (context, snapshot) {
        if (!snapshot.data) {
          return StreamBuilder<List<MateriaModel>>(
            stream: bloc.materias,
            initialData: [],
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return MultiSelectDropDown.error(
                  title: "Matérias",
                  error: "Erro ao buscar matérias",
                );
              }
              return MultiSelectDropDown<MateriaModel>(
                title: "Matérias",
                items: snapshot.data,
                onBuildName: (materia) => materia.nome,
                onSelect: bloc.onAddMateria,
              );
            },
          );
        } else {
          return MultiSelectDropDown.loading(title: "Matérias");
        }
      },
    );
  }

  Widget _anoFilter() {
    return StreamBuilder<bool>(
        stream: bloc.loadingAnos,
        initialData: true,
        builder: (context, snapshot) {
          if (!snapshot.data) {
            return StreamBuilder<List<String>>(
              stream: bloc.anos,
              initialData: null,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return MultiSelectDropDown.error(
                    error: "Erro ao carregar anos",
                    title: "Anos",
                  );
                }
                return MultiSelectDropDown<String>(
                    items: snapshot.data,
                    onBuildName: (ano) => ano,
                    onSelect: bloc.onAddAno,
                    title: "Anos");
              },
            );
          }
          return MultiSelectDropDown.loading(title: "Anos");
        });
  }

  Widget _submitButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: StreamBuilder<bool>(
        stream: bloc.loadingQuestoes,
        initialData: false,
        builder: (context, snapshot) {
          return GradientButton(
            onClick: () => bloc.onLoadQuestoes(context),
            title: "Iniciar",
            isLoading: snapshot.data
          );
        },
      )
    );
  }

  void _showUserProfile() {
    print("Pressed to show user profile!");
  }

  Future _onRefresh() async {
    return bloc.onRefresh();
  }
}
