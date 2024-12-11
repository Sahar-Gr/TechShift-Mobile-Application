import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:applicationpfe/app/modules/home/widgets/CustomPainterBar.dart';

class TimeDateBar extends StatelessWidget {
  final double width; // Largeur de la barre
  final double height; // Hauteur de la barre
  final double dateX; // Position X pour la date
  final double dateY; // Position Y pour la date
  final double timeX; // Position X pour l'heure
  final double timeY; // Position Y pour l'heure

  TimeDateBar({
    this.width = 500.0,
    this.height = 150.0,
    this.dateX = 210.0,
    this.dateY = 35.0,
    this.timeX = 230.0,
    this.timeY = 35.0,
  });

  @override
  Widget build(BuildContext context) {
    // Obtenir la date et l'heure actuelles
    String formattedDate = DateFormat('EEE, d MMM yyyy', 'fr_FR').format(DateTime.now());
    String formattedTime = DateFormat('HH:mm', 'fr_FR').format(DateTime.now());

    return CustomPaint(
      size: Size(width, height),
      painter: CustomBarPainter(),
      child: Container(
        color: Colors.transparent, // Fond transparent pour voir le dessin
        child: Stack(
          children: [
            Positioned(
              left: dateX,
              top: dateY,
              child: Text(
                formattedDate,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Digital7',
                ),
              ),
            ),
            Positioned(
              right: timeX,
              top: timeY,
              child: Text(
                formattedTime,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Digital7',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
