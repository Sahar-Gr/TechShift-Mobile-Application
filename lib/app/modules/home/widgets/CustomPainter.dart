import 'package:flutter/material.dart';

class BottomBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color.fromARGB(255, 12, 133, 129).withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Définir la largeur et la hauteur du trapèze
    final double trapezeWidth = size.width * 0.45; // Largeur du trapèze
    final double trapezeHeight = 80; // Hauteur fixe du trapèze
    final double topMargin = (size.width - trapezeWidth) / 2;
    
    final Path path = Path()
      ..moveTo(topMargin, 0) // Début en haut à gauche du trapèze
      ..lineTo(topMargin + trapezeWidth, 0) // Ligne vers le point en haut à droite du trapèze
      ..lineTo(topMargin + trapezeWidth * 0.8, trapezeHeight) // Ligne vers le point en bas à droite du trapèze
      ..lineTo(topMargin + trapezeWidth * 0.2, trapezeHeight) // Ligne vers le point en bas à gauche du trapèze
      ..close(); // Ferme le chemin en rejoignant le début

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom Painter Example'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
        bottomNavigationBar: CustomPaint(
          size: Size(double.infinity, 80), // Taille de la barre de navigation avec hauteur ajustée
          painter: BottomBarPainter(),
          child: Container(
            height: 80, // Hauteur de la barre de navigation ajustée
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.home, color: Colors.white),
                Icon(Icons.search, color: Colors.white),
                Icon(Icons.person, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
