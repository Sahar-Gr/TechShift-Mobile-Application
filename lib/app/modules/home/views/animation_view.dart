import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:applicationpfe/app/modules/home/views/home_menu_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:applicationpfe/constants/assets.dart'; // Importez la classe Assets

// Fonction pour récupérer la valeur de rapportEngage
Future<String> getRapportEngageValue() async {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref('Donnees_BV');
  final snapshot = await databaseReference.once();
  final data = snapshot.snapshot.value as Map?;

  if (data != null) {
    return data['Rapport_engage']?.toString() ?? '';
  }

  return '';
}

class AnimationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Animation'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.camera_front), text: 'Vue frontale'),
              Tab(icon: Icon(Icons.camera_rear), text: 'Vue côté'),
              Tab(icon: Icon(Icons.camera_alt), text: 'Vue du dos'),
            ],
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  FirebaseAuth.instance.currentUser?.email?.split('@').first ?? 'Utilisateur',
                ),
                accountEmail: Text(FirebaseAuth.instance.currentUser?.email ?? 'email@example.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage(Assets.assetsImagesProfil),
                ),
                decoration: BoxDecoration(
                  color:Color.fromARGB(255, 215, 101, 2),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () => Get.offAll(() => HomeMenuView()),
              ),
              ListTile(
                leading: Icon(Icons.speed),
                title: Text('Moteur'),
                onTap: () => Get.toNamed('/moteur'),
              ),
              ListTile(
                leading: Icon(Icons.play_arrow),
                title: Text('Boîte de Vitesse'),
                onTap: () => Get.toNamed('/bv'),
              ),
            ],
          ),
        ),
        body: FutureBuilder<String>(
          future: getRapportEngageValue(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              String rapportEngageValue = snapshot.data!;

              // Sélectionne la vidéo en fonction de la valeur de rapportEngage
              String videoUrl1, videoUrl2, videoUrl3;
              switch (rapportEngageValue) {
                case '1':
                  videoUrl1 = 'assets/videos/1/1.mp4';
                  videoUrl2 = 'assets/videos/1/2.mp4';
                  videoUrl3 = 'assets/videos/1/3.mp4';
                  break;
                case '2':
                  videoUrl1 = 'assets/videos/2/1.mp4';
                  videoUrl2 = 'assets/videos/2/2.mp4';
                  videoUrl3 = 'assets/videos/2/3.mp4';
                  break;
                case '3':
                  videoUrl1 = 'assets/videos/3/1.mp4';
                  videoUrl2 = 'assets/videos/3/2.mp4';
                  videoUrl3 = 'assets/videos/3/3.mp4';
                  break;
                case '4':
                  videoUrl1 = 'assets/videos/4/1.mp4';
                  videoUrl2 = 'assets/videos/4/2.mp4';
                  videoUrl3 = 'assets/videos/4/3.mp4';
                  break;
                case '5':
                  videoUrl1 = 'assets/videos/5/1.mp4';
                  videoUrl2 = 'assets/videos/5/2.mp4';
                  videoUrl3 = 'assets/videos/5/3.mp4';
                  break;
                case '6':
                  videoUrl1 = 'assets/videos/6/1.mp4';
                  videoUrl2 = 'assets/videos/6/2.mp4';
                  videoUrl3 = 'assets/videos/6/3.mp4';
                  break;
                default:
                  videoUrl1 = 'assets/videos/7/1.mp4';
                  videoUrl2 = 'assets/videos/7/2.mp4';
                  videoUrl3 = 'assets/videos/7/3.mp4';
              }

              return TabBarView(
                children: [
                  VideoPlayerWidget(videoUrl: videoUrl1),
                  VideoPlayerWidget(videoUrl: videoUrl2),
                  VideoPlayerWidget(videoUrl: videoUrl3),
                ],
              );
            } else {
              return Center(child: Text('Aucune donnée disponible.'));
            }
          },
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.asset(widget.videoUrl);
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
        ? Chewie(controller: _chewieController!)
        : Center(child: CircularProgressIndicator());
  }
}
