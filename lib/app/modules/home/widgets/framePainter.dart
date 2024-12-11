import 'package:flutter/material.dart';

class AnimatedFramePainter extends StatefulWidget {
  final double progress; // Progression de l'animation (entre 0 et 1)

  const AnimatedFramePainter({Key? key, required this.progress}) : super(key: key);

  @override
  _AnimatedFramePainterState createState() => _AnimatedFramePainterState();
}

class _AnimatedFramePainterState extends State<AnimatedFramePainter> with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Contrôle l'animation
  late Animation<double> _animation; // Détermine la progression de l'animation

  @override
  void initState() {
    super.initState();

    // Initialise le contrôleur d'animation avec une durée de 2 secondes
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: false); // Répète l'animation

    // Crée une animation qui progresse de 0 à 1
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        // Redessine le cadre à chaque changement de valeur de l'animation
        setState(() {});
      });
  }

  @override
  void dispose() {
    // Libère les ressources du contrôleur d'animation
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Utilise CustomPaint pour dessiner le cadre animé
    return CustomPaint(
      size: Size.infinite, // Occupe tout l'espace disponible
      painter: FramePainter(progress: _animation.value), // Passe la progression actuelle à FramePainter
    );
  }
}

class FramePainter extends CustomPainter {
  final double progress; // La progression de l'animation (de 0 à 1)

  FramePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final neonColor = Color.lerp(
      const Color.fromARGB(255, 10, 61, 103), // Couleur du néon pour la progression basse
      Color.fromARGB(255, 85, 39, 176), // Couleur du néon pour la progression haute
      progress,
    ) ?? Colors.blue;

    final glowPaint = Paint()
      ..color = neonColor.withOpacity(0.6) // Lueur atténuée
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0 // Épaisseur de la lueur
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10.0); // Applique un flou pour l'effet néon

    final paint = Paint()
      ..color = neonColor // Couleur du cadre
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0; // Épaisseur du cadre

    // Crée un chemin pour dessiner le cadre segment par segment
    final path = Path();

    // Dessine le segment supérieur du cadre
    path.moveTo(0, 350);
    path.lineTo(200, 20); 
    path.lineTo(360, 0); 

    // Dessine le segment du point (360, 0) au point (430, 20)
    path.lineTo(470, 80); 
    path.lineTo(820, 80); 
    path.lineTo(920, 0); 

    path.lineTo(1100, 20); 
    path.lineTo(1327, 300);
    path.lineTo(1100, 730);
    path.lineTo(200, 730);
    path.lineTo(0, 350); // Ferme le cadre

    // Dessine la lueur (en arrière-plan)
    canvas.drawPath(path, glowPaint);

    // Dessine le cadre (au-dessus de la lueur)s
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(FramePainter oldDelegate) {
    // Redessine uniquement si la progression a changé
    return oldDelegate.progress != progress;
  }
}
