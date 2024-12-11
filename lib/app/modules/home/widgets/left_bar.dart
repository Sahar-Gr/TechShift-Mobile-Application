import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:applicationpfe/app/modules/home/widgets/arc_painter.dart';

class LeftArc extends HookWidget {
  final double screenHeight;
  final double value; // Valeur de l'arc
  final Duration duration; // Durée de l'animation

  const LeftArc({
    Key? key,
    required this.screenHeight,
    this.value = 0, // Valeur par défaut
    this.duration = const Duration(milliseconds: 1000), // Durée par défaut
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: duration,
      lowerBound: 0,
      upperBound: 100,
    )..animateTo(value);

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return CustomPaint(
          size: Size(screenHeight * 0.4, (220 * screenHeight) / 480), // Ajustement de la taille
          painter: LeftPainter(
            radi: (170 * screenHeight) / 480,
            currentValue: animationController.value,
            bottomPadding: 15,
            color: Color.lerp(
              Color.fromARGB(255, 0, 255, 255), // Couleur pour valeurs basses (cyan)
              Color.fromARGB(255, 255, 0, 255),  // Couleur pour valeurs élevées (magenta)
              animationController.value / 100,
            ) ?? Color.fromARGB(255, 144, 173, 151),
          ),
        );
      },
    );
  }
}
