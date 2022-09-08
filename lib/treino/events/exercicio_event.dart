import 'package:training_timer/models/treino_model.dart';
import 'package:training_timer/treino/treino_event.dart';

class ExercicioEvent implements TreinoEvent {
  Treino treino;
  int now;

  ExercicioEvent({
    required this.treino,
    required this.now,
  });
}
