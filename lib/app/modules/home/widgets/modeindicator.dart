import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Importer FontAwesome

class ModeIndicator extends StatelessWidget {
  final String mode; // Mode actuel

  const ModeIndicator({Key? key, required this.mode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (mode) {
      case 'D':
        icon = FontAwesomeIcons.car; // Voiture en mouvement
        color = Colors.blue;
        break;
      case 'R':
        icon = FontAwesomeIcons.arrowAltCircleLeft; // Flèche de retour
        color = Colors.red;
        break;
      case 'S':
        icon = FontAwesomeIcons.tachometerAlt; // Icône de performance
        color = Colors.orange;
        break;
      case 'N':
        icon = FontAwesomeIcons.cogs; // Icône de levier de vitesse en neutre
        color = Colors.grey;
        break;
      case 'P':
        icon = FontAwesomeIcons.parking; // Icône de parking
        color = Colors.green;
        break;
      default:
        icon = FontAwesomeIcons.questionCircle; // Icône par défaut
        color = Colors.grey;
        break;
    }

    return Container(
      width: 500, // Spécifier une largeur fixe pour élargir le cadre
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16), // Rayon des coins
        border: Border.all(
          color: Colors.blueGrey.withOpacity(0.2),
          width: 2, // Épaisseur de la bordure
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 72, // Taille de l'icône
          ),
          SizedBox(height: 12), // Espacement entre l'icône et le texte
          Text(
            mode,
            style: TextStyle(
              fontSize: 32, // Taille du texte
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: 'Digital7', // Police numérique
            ),
          ),
        ],
      ),
    );
  }
}
