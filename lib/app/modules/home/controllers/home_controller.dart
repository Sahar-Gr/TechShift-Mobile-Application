import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:applicationpfe/app/routes/app_routes.dart';
import '../../../routes/app_pages.dart';

enum TAB { vitesse, temperature }

class HomeController extends GetxController with StateMixin {
  final user = FirebaseAuth.instance.currentUser;




  // Variables pour Donnees_BV
  RxDouble temperatureBV = 0.0.obs;
  RxDouble pression = 0.0.obs;
  RxString rapportEngage = ''.obs;
  RxString mode = ''.obs;

  // Variables pour Donnees_Moteur
  RxDouble vitesseMoteur = 0.0.obs;
  RxDouble RPMMoteur = 0.0.obs;
  RxDouble etatBatterie = 0.0.obs;
  RxDouble niveauCarburant = 0.0.obs;
  RxDouble temperatureMoteur = 0.0.obs;

  TAB tab = TAB.vitesse;
  final DatabaseReference _databaseReferenceBV =
      FirebaseDatabase.instance.ref('Donnees_BV');
  final DatabaseReference _databaseReferenceMoteur =
      FirebaseDatabase.instance.ref('Donnees_Moteur');

   @override
  void onInit() {
    // Écouter les changements de Donnees_BV
    _databaseReferenceBV.onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        temperatureBV(data['Temperature']?.toDouble() ?? 0.0);
        pression(data['Pression']?.toDouble() ?? 0.0);
        rapportEngage(data['Rapport_engage']?.toString() ?? '');
        mode(data['Mode']?.toString() ?? '');
      }
    });

    // Écouter les changements de Donnees_Moteur
    _databaseReferenceMoteur.onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        vitesseMoteur(data['Vitesse']?.toDouble() ?? 0.0);
        RPMMoteur(data['RPM']?.toDouble() ?? 0.0);
        etatBatterie(data['Etat_batterie']?.toDouble() ?? 0.0);
        niveauCarburant(data['Niveau_carburant']?.toDouble() ?? 0.0);
        temperatureMoteur(data['Temperature']?.toDouble() ?? 0.0);
      }
    });

    super.onInit();
  }


  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(Routes.SIGININ);
    } catch (e) {
      log("Error signing out: $e");
    }
  }

  void changeTab(int tab) {
    if (tab == 0) {
      this.tab = TAB.vitesse;
    } else {
      this.tab = TAB.temperature;
    }
    update(["tab"]);
  }
}
