import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:applicationpfe/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref('Donnees_BV');

  double temperature = 0.0;
  double vitesse = 0.0;
  String etatDefaillance = '';
  String mode = '';
  double pression = 0.0;
  String rapportEngage = '';

  TextEditingController searchController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _databaseReference.onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      setState(() {
        if (data != null) {
          temperature = data['Temperature']?.toDouble() ?? 0.0;
          vitesse = data['Vitesse']?.toDouble() ?? 0.0;
          etatDefaillance = data['Etat_defaillance']?.toString() ?? '';
          mode = data['Mode']?.toString() ?? '';
          pression = data['Pression']?.toDouble() ?? 0.0;
          rapportEngage = data['Rapport_engage']?.toString() ?? '';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suivi de Performance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Rechercher',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  if (searchText.isEmpty || 'vitesse'.contains(searchText))
                    _buildGaugeCard(
                      'Vitesse',
                      vitesse,
                      'Km/h',
                      0,
                      200,
                      [Colors.green, Colors.yellow, Colors.red],
                    ),
                  if (searchText.isEmpty || 'temperature'.contains(searchText))
                    _buildGaugeCard(
                      'Température',
                      temperature,
                      '°C',
                      0,
                      100,
                      [Colors.blue, Colors.orange, Colors.red],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (searchText.isEmpty || 'pression'.contains(searchText))
              _buildPressureIndicator(),
            const SizedBox(height: 16),
            if (searchText.isEmpty || 'etat defaillance'.contains(searchText))
              Text(
                'État de Défaillance: ${etatDefaillance == '1' ? 'Oui' : 'Non'}',
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Digital7',
                ),
              ),
            const SizedBox(height: 16),
            if (searchText.isEmpty || 'mode'.contains(searchText))
              _buildModeIndicator(),
            const SizedBox(height: 16),
            if (searchText.isEmpty || 'rapport engage'.contains(searchText))
              Text(
                'Rapport Engagé: $rapportEngage',
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Digital7',
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: const Icon(Icons.logout),
      ),
    );
  }

  Widget _buildGaugeCard(String title, double value, String unit, double min,
      double max, List<Color> colors) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Digital7'),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: min,
                    maximum: max,
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: min,
                          endValue: (max - min) * 0.5,
                          color: colors[0]),
                      GaugeRange(
                          startValue: (max - min) * 0.5,
                          endValue: (max - min) * 0.75,
                          color: colors[1]),
                      GaugeRange(
                          startValue: (max - min) * 0.75,
                          endValue: max,
                          color: colors[2]),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(value: value),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Container(
                          child: Text(
                            '$value $unit',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Digital7',
                            ),
                          ),
                        ),
                        angle: 90,
                        positionFactor: 0.75,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPressureIndicator() {
    return Column(
      children: [
        LinearProgressIndicator(
          value: pression / 100,
          backgroundColor: Colors.grey[200],
          color: pression > 75
              ? Colors.red
              : (pression > 50 ? Colors.orange : Colors.green),
          minHeight: 20,
        ),
        const SizedBox(height: 8),
        Text(
          'Pression: $pression',
          style: const TextStyle(fontSize: 18, fontFamily: 'Digital7'),
        ),
      ],
    );
  }

  Widget _buildModeIndicator() {
    Color modeColor;
    String modeText;
    switch (mode) {
      case 'S':
        modeColor = Colors.red;
        modeText = 'Sport';
        break;
      case 'D':
        modeColor = Colors.green;
        modeText = 'Drive';
        break;
      case 'P':
        modeColor = Colors.blue;
        modeText = 'Parking';
        break;
      case 'N':
        modeColor = Colors.orange;
        modeText = 'Neutral';
        break;
      default:
        modeColor = Colors.grey;
        modeText = 'Unknown';
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: modeColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'Mode: $modeText',
          style: const TextStyle(fontSize: 18, fontFamily: 'Digital7'),
        ),
      ],
    );
  }
}
