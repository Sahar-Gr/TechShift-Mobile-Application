import 'package:flutter/material.dart';

class FixedBVFramePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double radius;

  FixedBVFramePainter({
    this.color = const Color.fromARGB(255, 33, 54, 243),
    this.strokeWidth = 10.0,
    this.radius = 100.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Définir la taille du cadre fixe
    final rect = Rect.fromLTWH(
     6, // Position X du cadre
      10, // Position Y du cadre
      size.width-10 , // Largeur du cadre
      size.height - 15, // Hauteur du cadre
    );

    // Créer un rectangle avec des coins arrondis
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    // Dessiner le rectangle avec des coins arrondis
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Pas besoin de repeindre à chaque changement
  }
}
