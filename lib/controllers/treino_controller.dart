import 'package:training_timer/models/treino_model.dart';
import 'package:training_timer/treino/events/end_event.dart';
import 'package:training_timer/treino/events/exercicio_event.dart';
import 'package:training_timer/treino/events/start_event.dart';
import 'package:training_timer/treino/treino_event.dart';

class TreinoController {
  List<Treino> treinoTimers;

  TreinoController({required this.treinoTimers});

  Stream<TreinoEvent> start() async* {
    yield StartEvent();

    for (Treino treino in treinoTimers) {
      for (int seconds = treino.seconds; seconds >= 0; seconds--) {
        await Future.delayed(
          const Duration(seconds: 1),
        );
        yield ExercicioEvent(
          treino: treino,
          now: seconds,
        );
      }
    }

    yield EndEvent();
  }
}
