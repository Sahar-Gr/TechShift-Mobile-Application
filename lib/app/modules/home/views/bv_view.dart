import 'package:applicationpfe/app/modules/home/controllers/home_controller.dart';
import 'package:applicationpfe/app/modules/home/widgets/IconPressureChart.dart';
import 'package:applicationpfe/app/modules/home/widgets/ecran.dart';
import 'package:applicationpfe/app/modules/home/widgets/modeindicator.dart';
import 'package:applicationpfe/app/modules/home/widgets/rapportindicator.dart';
import 'package:applicationpfe/app/modules/home/widgets/temperaturewidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:applicationpfe/constants/assets.dart';
import 'package:applicationpfe/app/modules/home/views/home_menu_view.dart';
import 'package:applicationpfe/app/modules/home/widgets/BVFramePainter.dart';
import 'package:applicationpfe/app/modules/home/widgets/TimeDateBar.dart';

class BvView extends StatefulWidget {
  const BvView({super.key});

  @override
  _BvViewState createState() => _BvViewState();
}

class _BvViewState extends State<BvView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final HomeController controller = Get.find<HomeController>(); // Définir le contrôleur

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
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

    // Méthode pour extraire le nom d'utilisateur à partir de l'email
    String getUsernameFromEmail(String email) {
      return email.split('@').first;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Boîte de Vitesse'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user?.email != null ? getUsernameFromEmail(user!.email!) : 'Utilisateur'),
              accountEmail: Text(user?.email ?? 'email@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(Assets.assetsImagesProfil),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 215, 101, 2),
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
              leading: Icon(Icons.speed),
              title: Text('Moteur'),
              onTap: () => Get.toNamed('/moteur'),
            ),
            ListTile(
              leading: Icon(Icons.play_arrow),
              title: Text('Animation'),
              onTap: () => Get.toNamed('/animation'),
            ),
          ],
        ),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: FixedBVFramePainter(),
              child: Container(
                width: 1500,
                height: 900,
                child: Stack(
                  children: [
                    // Température en haut à gauche
                    Positioned(
                      top: 130,
                      left: 150,
                      child: GetX<HomeController>(builder: (_) {
                        return ClimatePage(
                          value: controller.temperatureBV.value,
                        );
                      }),
                    ),
                    // Position de la voiture entre température et pression
                    Positioned(
                      top: 130,
                      left: 510, // Ajustez cette valeur si nécessaire
                      child: CarPositionPage(),
                    ),

                    // Pression en haut à droite
                    Positioned(
                      top: 130,
                      left: 850,
                      child: GetX<HomeController>(builder: (_) {
                        return IconPressureChart(
                          pressure: controller.pression.value,
                        );
                      }),
                    ),
                    // Mode en bas à gauche
                    Positioned(
                      bottom: 35,
                      left: 150,
                      child: GetX<HomeController>(builder: (_) {
                        return ModeIndicator(
                          mode: controller.mode.value,
                        );
                      }),
                    ),
                    // Rapport engagé en bas à droite
                    Positioned(
                      bottom: 35,
                      left: 700,
                      child: GetX<HomeController>(builder: (_) {
                        return RapportIndicator(
                          rapport: int.tryParse(controller.rapportEngage.value) ?? 0,
                        );
                      }),
                    ),
                    // Time and Date bar horizontalement centré
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: TimeDateBar(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
