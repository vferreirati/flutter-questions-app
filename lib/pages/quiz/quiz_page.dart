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
  FiltroModel get _filtro => widget.filtro;

  @override
  void initState() {
    super.initState();
    _bloc.setup(_initialQuestions, _filtro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle(_isHardcoreMode ? "Simulado" : "Questões"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.warning),
            onPressed: _onNotifyBadQuestion
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Text("Questão será exibida aqui!"),
        ),
      ),
    );
  }

  void _onNotifyBadQuestion() {
    print("Apertou para notificar erro na questão!");
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
