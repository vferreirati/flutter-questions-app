import 'package:exata_questoes_app/models/api/simulado_model.dart';
import 'package:exata_questoes_app/pages/home/home_page.dart';
import 'package:exata_questoes_app/pages/quiz/quiz_bloc.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class ResultPage extends StatelessWidget {
  final SimuladoModel simulado;
  final List<RespostaModel> respostas;

  ResultPage({
    @required this.simulado,
    @required this.respostas
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToHome(context),
        child: Icon(Icons.arrow_forward, size: 30,),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildPartyEmoji(),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Parabéns!",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: "MavenPro",
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Você concluiu o simulado ${simulado.nome}!",
                  style: TextStyle(fontSize: 20, fontFamily: "MavenPro", ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25,
                ),
                _buildSumarioMaterias()
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _buildPartyEmoji() {
    return Image.asset(
      "assets/images/party_emoji.png",
      height: 128,
      width: 128,
    );
  }

  Widget _buildSumarioMaterias() {
    final materias = List<String>();
    simulado.questoes.forEach((q) {
      if(!materias.contains(q.materia.nome)) {
        materias.add(q.materia.nome);
      }
    });

    final respostasCorretas = Map<String, int>.fromIterable(
      materias,
      key: (materia) => materia,
      value: (_) => 0
    );
    final totalQuestoes = Map<String, int>.fromIterable(
        materias,
        key: (materia) => materia,
        value: (_) => 0
    );
    simulado.questoes.forEach((q) {
      totalQuestoes[q.materia.nome] += 1;
      final alternativaCorreta = q.alternativas.firstWhere((alt) => alt.correta);
      final resposta = respostas.firstWhere((r) => r.questaoId == q.id);

      if(resposta.alternativaId == alternativaCorreta.id) {
        respostasCorretas[q.materia.nome] += 1;
      }
      respostas.remove(resposta);
    });

    final children = List<Widget>();
    materias.forEach((materia) {
      children.add(Text(
        "${respostasCorretas[materia]} de ${totalQuestoes[materia]} questões de $materia corretas",
        style: TextStyle(fontSize: 18, fontFamily: "MavenPro"),
        textAlign: TextAlign.center,
      ));
      children.add(SizedBox(
        height: 10,
      ));
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  void _navigateToHome(BuildContext context) {
    final route = MaterialPageRoute(
      builder: (context) => HomePage(homeBloc: kiwi.Container().resolve(),)
    );
    Navigator.of(context).push(route);
  }
}
