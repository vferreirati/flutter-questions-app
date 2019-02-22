import 'package:exata_questoes_app/models/api/questao_model.dart';
import 'package:exata_questoes_app/models/filtro_model.dart';
import 'package:exata_questoes_app/pages/quiz/quiz_bloc.dart';
import 'package:exata_questoes_app/widgets/text.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final List<QuestaoModel> initialQuestions;
  final bool isHardcoreMode;
  final QuizBloc bloc;
  final FiltroModel filtro;

  QuizPage({
    @required this.initialQuestions,
    @required this.bloc,
    @required this.filtro,
    this.isHardcoreMode = false,
  });

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool get _isHardcoreMode => widget.isHardcoreMode;
  List<QuestaoModel> get _initialQuestions => widget.initialQuestions;
  QuizBloc get _bloc => widget.bloc;

  @override
  void initState() {
    super.initState();
    _bloc.setup(_initialQuestions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle(_isHardcoreMode ? "Simulado" : "Questões"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.warning), onPressed: _onNotifyBadQuestion)
        ],
      ),
      body: StreamBuilder<List<QuestaoModel>>(
        stream: _bloc.questoes,
        initialData: _initialQuestions,
        builder: (context, snapshot) {
          return PageView.builder(
            controller: _bloc.pageController,
            itemCount: _bloc.calculatePageCount(),
            onPageChanged: _bloc.onPageChanged,
            itemBuilder: (context, index) => _buildPageItem(context, index, snapshot.data[index]),
          );
        },
      ),
    );
  }

  Widget _buildPageItem(BuildContext context, int index, QuestaoModel questao) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 8, right: 8),
        child: Column(
          children: <Widget>[
            _buildEnunciado(questao),
            SizedBox(height: 10),
            Column(children: _buildAlternativas(questao))
          ],
        ),
      ),
    );
  }

  Widget _buildEnunciado(QuestaoModel questao) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Text(
          "[${questao.banca.nome} - ${questao.ano}] ${questao.enunciado}",
          style: TextStyle(fontFamily: "MavenPro", fontSize: 12),
        ),
      ),
    );
  }

  List<Widget> _buildAlternativas(QuestaoModel questao) {
    return List<Widget>.generate(questao.alternativas.length, (index) {
      final alternativa = questao.alternativas[index];
      return GestureDetector(
        onTap: () => _bloc.onAlternativaSelected(questao.id, alternativa.id),
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: StreamBuilder<List<RespostaModel>>(
              stream: _bloc.respostas,
              initialData: [],
              builder: (context, snapshot) {
                final resposta = snapshot.data?.firstWhere((resp) => resp.questaoId == questao.id, orElse: () => null);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Radio<int>(
                      value: questao.alternativas[index].id,
                      groupValue: resposta == null ? -1 : resposta.alternativaId,
                      onChanged: (alternativaId) => _bloc.onAlternativaSelected(questao.id, alternativaId),
                    ),
                    Text(alternativa.corpo,
                        style: TextStyle(fontFamily: "MavenPro", fontSize: 12))
                  ],
                );
              },
            ),
          ),
        ),
      );
    });
  }

  void _onNotifyBadQuestion() {
    print("Apertou para notificar erro na questão!");
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    print("On dispose");
  }
}
