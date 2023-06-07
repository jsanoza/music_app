import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  String animation = 'idle';

  Artboard? _birdArtboard;
  SMITrigger? trigger;
  StateMachineController? stateMachineController;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/play_pause.riv').then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        stateMachineController =
            StateMachineController.fromArtboard(artboard, "State Machine 1");
        if (stateMachineController != null) {
          artboard.addController(stateMachineController!);
          trigger = stateMachineController!.findSMI('Play');

          stateMachineController!.inputs.forEach((e) {
            debugPrint("${e.name}");
          });
          trigger = stateMachineController!.inputs.last as SMITrigger;
        }
        setState(() => _birdArtboard = artboard);
      },
    );
  }

  void jump() {
    trigger?.fire();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 400,
                child: _birdArtboard == null
                    ? const SizedBox()
                    : Center(
                        child: GestureDetector(
                          onTap: () {
                            jump();
                          },
                          child: Rive(artboard: _birdArtboard!),
                        ),
                      ),
              ),
            ],
          ),
        ));
  }
}
