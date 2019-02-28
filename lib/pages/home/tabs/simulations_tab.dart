import 'package:exata_questoes_app/models/api/simulado_model.dart';
import 'package:exata_questoes_app/pages/home/home_bloc.dart';
import 'package:exata_questoes_app/widgets/text.dart';
import 'package:flutter/material.dart';

class SimulationsTab extends StatelessWidget {
  final HomeBloc bloc;

  SimulationsTab({this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildSearchBar(),
          SizedBox(height: 10,),
          _buildSimulados()
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        child: TextField(
          onChanged: bloc.onSearchSimulado,
          decoration: InputDecoration(
            hintText: "Pesquise um simulado",
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none
          )
        ),
      ),
    );
  }

  Widget _buildSimulados() {
    return Expanded(
        child: StreamBuilder<List<SimuladoModel>>(
        stream: bloc.simulados,
        initialData: null,
        builder: (context, snapshot) {
          if(snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final simulados = snapshot.data;
          return ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(0),
            itemCount: simulados.length,
            itemBuilder: (context, index) {
              final simulado = simulados[index];
              return Card(
                child: ListTile(
                  onTap: () => bloc.onSelectSimulado(context, simulado),
                  title: tileText(title: simulado.nome),
                  trailing: Icon(Icons.navigate_next, color: Colors.grey,),
                ),
              );
            }            
          );
        }
      ),
    );
  }
}
