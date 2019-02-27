import 'package:exata_questoes_app/models/api/alternativa_model.dart';
import 'package:exata_questoes_app/models/api/questao_model.dart';
import 'package:exata_questoes_app/models/api/simulado_model.dart';
import 'package:exata_questoes_app/models/filtro_model.dart';
import 'package:exata_questoes_app/pages/quiz/quiz_bloc.dart';
import 'package:exata_questoes_app/widgets/text.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final SimuladoModel simulado;
  final bool isHardcoreMode;
  final QuizBloc bloc;
  final FiltroModel filtro;

  QuizPage({
    @required this.bloc,
    @required this.filtro,
    @required this.simulado,
    this.isHardcoreMode = false,
  });

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool get _isHardcoreMode => widget.isHardcoreMode;
  QuizBloc get _bloc => widget.bloc;
  SimuladoModel get _simulado => widget.simulado;

  @override
  Widget build(BuildContext context) {
    _bloc.setup(simulado: _simulado, context: context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: Builder(
          builder: (builderContext) => AppBar(
            title: appBarTitle(_isHardcoreMode ? "Simulado" : "Questões"),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.warning),
                  onPressed: () => _onNotifyBadQuestion(builderContext))
            ],
          ),
        ),
      ),
      body: StreamBuilder<List<QuestaoModel>>(
        stream: _bloc.questoes,
        initialData: null,
        builder: (context, snapshot) {
          if(snapshot.data != null) {
            return PageView.builder(
              controller: _bloc.pageController,
              itemCount: snapshot.data.length,
              onPageChanged: _bloc.onPageChanged,
              itemBuilder: (context, index) {
                return _buildQuestaoItem(context, snapshot.data[index]);
              }
            );
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }

  Widget _buildQuestaoItem(BuildContext context, QuestaoModel questao) {
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
          style: TextStyle(fontFamily: "MavenPro", fontSize: 15),
        ),
      ),
    );
  }

  List<Widget> _buildAlternativas(QuestaoModel questao) {
    return List<Widget>.generate(questao.alternativas.length, (index) {
      final alternativa = questao.alternativas[index];
      return GestureDetector(
        onTap: () {
          if(_isHardcoreMode && _bloc.questaoFoiRespondida(questao.id)) {
            return;
          }
          _bloc.onAlternativaSelected(questao.id, alternativa.id);
          if(_isHardcoreMode) {
            _bloc.verificarQuestoesRespondidas();
          }
        },
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: StreamBuilder<List<RespostaModel>>(
              stream: _bloc.respostas,
              initialData: [],
              builder: (context, snapshot) {
                final resposta = snapshot.data?.firstWhere(
                    (resp) => resp.questaoId == questao.id,
                    orElse: () => null);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Radio<int>(
                        value: questao.alternativas[index].id,
                        groupValue:
                            resposta == null ? -1 : resposta.alternativaId,
                        onChanged: (alternativaId) {
                          if(_isHardcoreMode && _bloc.questaoFoiRespondida(questao.id)) {
                            return;
                          }
                          _bloc.onAlternativaSelected(questao.id, alternativaId);
                          if(_isHardcoreMode) {
                            _bloc.verificarQuestoesRespondidas();
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(alternativa.corpo,
                          style:
                              TextStyle(fontFamily: "MavenPro", fontSize: 13)),
                    ),
                    Expanded(
                      child: (resposta == null)
                          ? Container()
                          : ((_isHardcoreMode)
                              ? Container()
                              : _buildAlternativaIcon(alternativa)),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      );
    });
  }

  Widget _buildAlternativaIcon(AlternativaModel alternativa) {
    return Icon(
      alternativa.correta ? Icons.check : Icons.close,
      color: alternativa.correta ? Colors.greenAccent : Colors.redAccent,
    );
  }

  void _onNotifyBadQuestion(BuildContext scaffoldContext) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: dialogTitle(title: "Informar erro na questão:"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _bloc.errorTextController,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: "O que há de errado?",
                        hintStyle: TextStyle(fontFamily: "MavenPro")),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          _bloc.onErrorSubmit(scaffoldContext);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Enviar",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontFamily: "MavenPro"),
                        ),
                      ),
                      FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontFamily: "MavenPro"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ));
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
