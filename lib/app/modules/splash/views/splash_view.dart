import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:applicationpfe/app/routes/app_routes.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Redirige vers la page de connexion lorsque l'utilisateur clique sur l'écran
          Get.offNamed(Routes.SIGININ);
        },
        child: Stack(
          children: [
            // Fond d'écran
            Positioned.fill(
              child: Container(
                color: Color.fromARGB(255, 8, 2, 24),
                child: Center(
                  child: Image.asset(
                    'assets/images/spalsh.jpg', // Remplacez par le chemin de votre image de fond
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Logo Ennakl en haut à gauche
            Positioned(
              top: 70.0,
              left: 16.0,
              child: Image.asset(
                'assets/images/logo.png', // Remplacez par le chemin de votre logo Ennakl
                height: 100.0,
              ),
            ),
            // Logo Esprit en haut à droite avec fond plus clair
            Positioned(
              top: 70.0,
              right: 16.0,
              child: Container(
                padding: EdgeInsets.all(8.0), // Ajoute un peu de padding autour du logo
                color: Color.fromARGB(13, 155, 111, 61).withOpacity(0.7), // Fond plus clair avec opacité
                child: Image.asset(
                  'assets/images/logoesprit.png', // Remplacez par le chemin de votre logo Esprit
                  height: 80.0,
                ),
              ),
            ),
            // Texte sous les logos
            Positioned(
              top: 180.0,
              left: 16.0,
              right: 16.0,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Projet Fin d\'Etudes:',
                      style: TextStyle(
                        color: Color.fromARGB(255, 182, 57, 57),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Conception d\'une Interface d\'Affichage et de Suivi pour Boîte de Vitesses DSG 0AM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Texte sous l'image de fond
            Positioned(
              bottom: 50.0,
              left: 16.0,
              right: 16.0,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Réalisé par : Sahar Grira',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Encadré par: Sahraoui Wajdi / Taoufik Chaouachi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
