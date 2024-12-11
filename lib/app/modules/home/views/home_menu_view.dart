import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:applicationpfe/constants/assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:applicationpfe/app/modules/siginin/views/siginin_view.dart';
import 'package:applicationpfe/app/modules/siginin/controllers/siginin_controller.dart';
import 'package:applicationpfe/app/core/themes/appthemes.dart';


class HomeMenuView extends StatefulWidget {
  const HomeMenuView({super.key});

  @override
  _HomeMenuViewState createState() => _HomeMenuViewState();
}

class _HomeMenuViewState extends State<HomeMenuView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    String getUsernameFromEmail(String email) {
      return email.split('@').first;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Principal'),
        backgroundColor: Color.fromARGB(54, 98, 101, 101), // Couleur grise personnalisée pour la barre d'application
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // Photo de profil et informations de l'utilisateur
            UserAccountsDrawerHeader(
              accountName: Text(user?.email != null ? getUsernameFromEmail(user!.email!) : 'Utilisateur'),
              accountEmail: Text(user?.email ?? 'email@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(Assets.assetsImagesProfil),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).drawerTheme.backgroundColor,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Get.offAll(() => HomeMenuView());
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => Get.toNamed('/settings'),
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                await _auth.signOut();
                Get.find<SigininController>().emailController.clear();
                Get.find<SigininController>().passwordController.clear();
                Get.offAll(() => SigininView());
              },
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity, // Prend toute la largeur de l'écran
        height: double.infinity, // Prend toute la hauteur de l'écran
        color: Colors.black, // Fond noir
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Nom de l'application avec animation et dégradé
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ScaleTransition(
                scale: _animation,
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [ Color.fromARGB(255, 211, 120, 2), Color.fromARGB(255, 0, 255, 187),Color.fromARGB(255, 17, 0, 170)],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds),
                  child: Text(
                    'GearShift Pro by Ennakl',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // This color will be masked by the gradient
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            // Logo au centre avec ombre
            Expanded(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // Changez l'offset si nécessaire
                      ),
                    ],
                  ),
                  child: Image.asset(
                    Assets.assetsImagesICLAUNCHER,
                    width: 170,
                    height: 170,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            // Boutons modernes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Get.toNamed('/moteur'),
                    icon: Icon(Icons.engineering, color: Colors.white),
                    label: Text('Moteur'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 17, 0, 170), // Couleur de fond moderne
                      foregroundColor: Colors.white, // Couleur du texte blanc
                      minimumSize: Size(double.infinity, 70), // Taille fixe avec largeur pleine et hauteur augmentée
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => Get.toNamed('/bv'),
                    icon: Icon(Icons.settings_applications, color: Colors.white),
                    label: Text('Boîte de Vitesse'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 255, 187), // Couleur de fond moderne
                      foregroundColor: Colors.black, // Couleur du texte noir
                      minimumSize: Size(double.infinity, 70), // Taille fixe avec largeur pleine et hauteur augmentée
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => Get.toNamed('/animation'),
                    icon: Icon(Icons.movie, color: Colors.white),
                    label: Text('Animation'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 211, 120, 2), // Couleur de fond moderne
                      foregroundColor: Colors.white, // Couleur du texte blanc
                      minimumSize: Size(double.infinity, 70), // Taille fixe avec largeur pleine et hauteur augmentée
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30), // Espace supplémentaire en bas
          ],
        ),
      ),
    );
  }
}