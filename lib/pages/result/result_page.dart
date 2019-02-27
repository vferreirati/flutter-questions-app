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
                Text(
                  "5 de 10 questões de português corretas",
                  style: TextStyle(fontSize: 18, fontFamily: "MavenPro"),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "5 de 10 questões de matemática corretas",
                  style: TextStyle(fontSize: 18, fontFamily: "MavenPro"),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "5 de 10 questões de física corretas",
                  style: TextStyle(fontSize: 18, fontFamily: "MavenPro"),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "5 de 10 questões de química corretas",
                  style: TextStyle(fontSize: 18, fontFamily: "MavenPro"),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                )
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

  void _navigateToHome(BuildContext context) {
    final route = MaterialPageRoute(
      builder: (context) => HomePage(homeBloc: kiwi.Container().resolve(),)
    );
    Navigator.of(context).push(route);
  }
}
