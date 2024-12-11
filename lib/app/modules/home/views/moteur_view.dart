import 'package:applicationpfe/app/core/themes/appthemes.dart';
import 'package:applicationpfe/app/modules/home/views/home_menu_view.dart';
import 'package:applicationpfe/app/modules/home/widgets/CustomPainter.dart';
import 'package:applicationpfe/app/modules/home/widgets/framePainter.dart';
import 'package:applicationpfe/app/modules/home/widgets/gaugeBattery.dart';
import 'package:applicationpfe/app/modules/home/widgets/gaugecard.dart';
import 'package:applicationpfe/app/modules/home/widgets/left_bar.dart';
import 'package:applicationpfe/app/modules/home/widgets/right_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:applicationpfe/constants/assets.dart';
import 'package:intl/intl.dart';
import '../controllers/home_controller.dart';
import 'package:applicationpfe/app/modules/home/widgets/gaugeRPM.dart';

class MoteurView extends GetView<HomeController> {
  const MoteurView({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    String getUsernameFromEmail(String email) {
      return email.split('@').first;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Moteur'),
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
              title: Text('Boîte de Vitesse'),
              onTap: () => Get.toNamed('/bv'),
            ),
            ListTile(
              leading: Icon(Icons.play_arrow),
              title: Text('Animation'),
              onTap: () => Get.toNamed('/animation'),
            ),
          ],
        ),
      ),
      body: CustomPaint(
        painter: FramePainter(progress: 1.0),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 60),
                painter: BottomBarPainter(),
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/calendar.png',
                        width: 50,
                        height: 50,
                      ),
                      Text(
                        DateFormat('EEEE').format(DateTime.now()).substring(0, 3),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Digital7',
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 20),
                      Image.asset(
                        'assets/images/watch.png',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontFamily: 'Digital7',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 20),
                      Image.asset(
                        'assets/images/weather.png',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(width: 15),
                      Obx(
                        () => Text(
                          "${controller.temperatureMoteur.value}°C",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontFamily: 'Digital7',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder<HomeController>(
                  id: 'tab',
                  builder: (_) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Row(
                                    children: [
                                      Transform.translate(
                                        offset: Offset(-50, 0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          height: MediaQuery.of(context).size.width * 0.2,
                                          child: LeftArc(
                                            screenHeight: MediaQuery.of(context).size.height,
                                            value: controller.temperatureMoteur.value,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Transform.translate(
                                        offset: Offset(-50, 0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.3,
                                          height: MediaQuery.of(context).size.width * 0.3,
                                          child: GaugeRPM(
                                            value: controller.RPMMoteur.value,
                                            unit: 'RPM',
                                            colors: const [Colors.green, Colors.yellow, Colors.red],
                                            title: '',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 80),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.3,
                                        height: MediaQuery.of(context).size.width * 0.3,
                                        child: GaugeSpeed(
                                          value: controller.vitesseMoteur.value,
                                          unit: 'Km/h',
                                          colors: const [Colors.green, Colors.yellow, Colors.red],
                                          title: '',
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        height: MediaQuery.of(context).size.width * 0.2,
                                        child: RightArc(
                                          screenHeight: MediaQuery.of(context).size.height,
                                          value: controller.niveauCarburant.value,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset(
                                'assets/images/battery.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Obx(
                              () => Text(
                                '${controller.etatBatterie.value}%',
                                style: TextStyle(
                                  fontFamily: 'Digital7',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height:20),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            double gaugeWidth = constraints.maxWidth * 0.6;
                            double gaugeHeight = 85;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                padding: const EdgeInsets.only(bottom: 70.0), // Ajuster la marge inférieure ici
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: gaugeWidth,
                    height: gaugeHeight,
                    child: GaugeBattery(
                      value: controller.etatBatterie.value,
                      unit: '%',
                    ),
                  ),
                ),
              ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 415,
              right: 1060,
              child: Image.asset(
                'assets/images/engine-coolant2.png',
                width: 40,
                height:40,
              ),
            ),
            Positioned(
              top: 405,
              right: 95,
              child: Image.asset(
                'assets/images/fuel_icon.png',
                width: 40,
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
