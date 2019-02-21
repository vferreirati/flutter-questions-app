// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void configure() {
    final Container container = Container();
    container.registerSingleton((c) => RequestService());
    container
        .registerSingleton<AnoService, AnoMockService>((c) => AnoMockService());
    container.registerSingleton<MateriaService, MateriaMockService>(
        (c) => MateriaMockService());
    container.registerSingleton<QuestaoService, QuestaoMockService>(
        (c) => QuestaoMockService());
    container.registerSingleton<SimuladoService, SimuladoMockService>(
        (c) => SimuladoMockService());
    container.registerFactory((c) => HomeBloc(c<SimuladoService>(),
        c<AnoService>(), c<MateriaService>(), c<QuestaoService>()));
  }
}
