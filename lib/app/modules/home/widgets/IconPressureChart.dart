import 'package:flutter/material.dart';

class IconPressureChart extends StatelessWidget {
  final double pressure;

  IconPressureChart({required this.pressure});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -20, // Diminuez cette valeur pour augmenter la position verticale
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Cercle de pression avec dégradé smooth
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        pressure > 95 ? Colors.red
                            : pressure > 90 ? Colors.deepOrange
                            : pressure > 85 ? Colors.orange
                            : pressure > 80 ? Colors.amber
                            : pressure > 75 ? Colors.yellow
                            : pressure > 70 ? Colors.lightGreen
                            : pressure > 65 ? Colors.green
                            : pressure > 60 ? Colors.teal
                            : pressure > 55 ? Colors.cyan
                            : pressure > 50 ? Colors.blue
                            : pressure > 45 ? Colors.indigo
                            : pressure > 40 ? Colors.purple
                            : pressure > 35 ? Colors.pink
                            : pressure > 30 ? Colors.deepPurple
                            : pressure > 25 ? Colors.brown
                            : pressure > 20 ? Colors.grey
                            : pressure > 15 ? Colors.blueGrey
                            : pressure > 10 ? Colors.black54
                            : pressure > 5 ? Colors.black87
                            : Colors.black,
                        Colors.transparent,
                      ],
                      stops: [0.7, 1.0],
                      center: Alignment.center,
                      radius: 0.5,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                // Cercle de pression avec ombre et taille en fonction de la pression
                Container(
                  width: 300 * (pressure / 100),
                  height: 300 * (pressure / 100),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: pressure > 95 ? Colors.red
                          : pressure > 90 ? Colors.deepOrange
                          : pressure > 85 ? Colors.orange
                          : pressure > 80 ? Colors.amber
                          : pressure > 75 ? Colors.yellow
                          : pressure > 70 ? Colors.lightGreen
                          : pressure > 65 ? Colors.green
                          : pressure > 60 ? Colors.teal
                          : pressure > 55 ? Colors.cyan
                          : pressure > 50 ? Colors.blue
                          : pressure > 45 ? Colors.indigo
                          : pressure > 40 ? Colors.purple
                          : pressure > 35 ? Colors.pink
                          : pressure > 30 ? Colors.deepPurple
                          : pressure > 25 ? Colors.brown
                          : pressure > 20 ? Colors.grey
                          : pressure > 15 ? Colors.blueGrey
                          : pressure > 10 ? Colors.black54
                          : pressure > 5 ? Colors.black87
                          : Colors.black,
                      width: 6, // Réduit l'épaisseur de la bordure pour un look plus raffiné
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8, // Réduit le flou de l'ombre pour un effet plus subtil
                        spreadRadius: 3, // Réduit l'étendue de l'ombre
                      ),
                    ],
                  ),
                ),
                // Texte de la pression avec style personnalisé
                Positioned(
                  child: Text(
                    '${pressure.toStringAsFixed(1)} bar',
                    style: TextStyle(
                      fontFamily: 'DancingScript', // Utilisez le nom de la famille de police ici
                      color: Colors.black,
                      fontSize: 30, // Agrandit la taille de la police
                      fontWeight: FontWeight.normal, // Changez en FontWeight.normal pour un effet plus fin
                      shadows: [
                        Shadow(
                          blurRadius: 4.0, // Réduit le flou de l'ombre pour un effet plus subtil
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
