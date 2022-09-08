import 'package:flutter/material.dart';
import 'package:training_timer/controllers/treino_controller.dart';
import 'package:training_timer/models/treino_model.dart';
import 'package:training_timer/treino/events/end_event.dart';
import 'package:training_timer/treino/events/exercicio_event.dart';
import 'package:training_timer/treino/events/start_event.dart';
import 'package:training_timer/treino/treino_event.dart';
import 'package:training_timer/ui/widgets/count_down.dart';

class TreinoPage extends StatefulWidget {
  const TreinoPage({Key? key}) : super(key: key);

  @override
  State<TreinoPage> createState() => _TreinoPageState();
}

class _TreinoPageState extends State<TreinoPage> {
  bool showStartButton = true;
  late final TreinoController controller;
  late final Stream<TreinoEvent> treinoStream;

  start() {
    controller = TreinoController(
      treinoTimers: [
        Treino(seconds: 10, name: 'Abs'),
        Treino(seconds: 10, name: 'Descanso'),
        Treino(seconds: 10, name: 'Prancha'),
      ],
    );

    setState(() {
      treinoStream = controller.start();
      showStartButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: showStartButton
              ? ElevatedButton(
                  child: const Text('Iniciar Trteino'),
                  onPressed: start,
                )
              : StreamBuilder(
                  stream: treinoStream,
                  builder: (context, AsyncSnapshot<TreinoEvent> snapshot) {
                    TreinoEvent? event = snapshot.data;
                    if (snapshot.hasError) {
                      return const Text('Erro ao carregar o treino');
                    } else if (event is StartEvent) {
                      return const Text('Iniciando o treino...');
                    } else if (event is EndEvent) {
                      return const Text('Finalizando o treino...');
                    } else if (event is ExercicioEvent) {
                      return CountDown(event: event);
                    }

                    return Container();
                  },
                )),
    );
  }
}
