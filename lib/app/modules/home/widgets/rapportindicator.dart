import 'package:flutter/material.dart';

class RapportIndicator extends StatefulWidget {
  final int rapport; // Le rapport engagé

  const RapportIndicator({Key? key, required this.rapport}) : super(key: key);

  @override
  _RapportIndicatorState createState() => _RapportIndicatorState();
}

class _RapportIndicatorState extends State<RapportIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 16), // Durée prolongée pour ralentir l'animation
      vsync: this,
    )..repeat(); // Répéter l'animation en boucle

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * 3.14159).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 181, // Spécifier une largeur fixe pour élargir le cadre
      padding: const EdgeInsets.all(24.0), // Augmenter le padding pour correspondre à la largeur
      decoration: BoxDecoration(
        color: Colors.transparent, // Fond totalement transparent
        borderRadius: BorderRadius.circular(16), // Augmenter le rayon des coins
        border: Border.all(
          color: const Color.fromARGB(255, 244, 219, 54).withOpacity(0.2), // Couleur de contour légèrement visible
          width: 2, // Augmenter l'épaisseur de la bordure
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RotationTransition(
            turns: _rotationAnimation,
            child: Icon(
              Icons.speed, // Icône pour le rapport engagé
              color: Color.fromARGB(141, 193, 206, 7), // Couleur de l'icône
              size: 60, // Agrandir la taille de l'icône
            ),
          ),
          SizedBox(width: 16), // Espacement entre l'icône et le texte
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Rapport Engage',
                style: TextStyle(
                  fontFamily: 'Digital7', // Police numérique
                  fontSize: 24, // Taille du texte
                  color: Colors.red, // Couleur du titre
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8), // Espacement entre les lignes de texte
              Text(
                '${widget.rapport}',
                style: TextStyle(
                  fontFamily: 'Digital7', // Police numérique
                  fontSize: 48, // Taille du texte du rapport
                  color: Colors.lightGreenAccent, // Couleur vive
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
