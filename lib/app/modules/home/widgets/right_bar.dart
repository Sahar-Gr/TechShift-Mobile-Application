import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:applicationpfe/app/modules/home/widgets/arc_painter.dart';

class RightArc extends HookWidget {
  final double screenHeight;
  final double value; // Valeur de l'arc
  final Duration duration; // Durée de l'animation

  const RightArc({
    Key? key,
    required this.screenHeight,
    this.value = 0, // Valeur par défaut
    this.duration = const Duration(milliseconds: 800), // Durée par défaut
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
          painter: RightPainter(
            radi: (170 * screenHeight) / 480,
            currentValue: animationController.value,
            bottomPadding: 17,
            color: Color.lerp(
              Color.fromARGB(255, 255, 69, 58), // Couleur pour niveau bas (rouge vif)
              Color.fromARGB(255, 0, 255, 0),   // Couleur pour niveau plein (vert vif)
              animationController.value / 100,
            ) ?? Colors.blue,
          ),
        );
      },
    );
  }
}
