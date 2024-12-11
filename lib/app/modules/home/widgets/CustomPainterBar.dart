import 'package:flutter/material.dart';

class CustomBarPainter extends CustomPainter {
  final Color color;

  CustomBarPainter({this.color = const Color.fromARGB(255, 33, 58, 243)});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Dessine le segment supérieur du cadre
    path.moveTo(0, 350);
    path.lineTo(200,10); 
    path.lineTo(360, 10); 

    // Dessine le segment du point (360, 0) au point (430, 20)
    path.lineTo(470, 80); 
    path.lineTo(920, 80); 
    path.lineTo(1000, 10); 

    path.lineTo(1100, 10); 
    path.lineTo(1327, 300);
    path.lineTo(1100, 100);
    path.lineTo(200, 100);
    path.lineTo(0, 350); // Ferme le cadre

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Pas besoin de repeindre à chaque changement
  }
}
