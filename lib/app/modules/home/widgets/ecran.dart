import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class CarPositionPage extends StatefulWidget {
  @override
  _CarPositionPageState createState() => _CarPositionPageState();
}

class _CarPositionPageState extends State<CarPositionPage> {
  Location _location = Location();
  LocationData? _currentLocation;
  final MapController _mapController = MapController();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    // Vérifiez si le service de localisation est activé
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        // Vous pouvez afficher une alerte ici
        return;
      }
    }

    // Vérifiez la permission de localisation
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        // Vous pouvez afficher une alerte ici
        return;
      }
    }

    // Obtenez la position actuelle
    _location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentLocation = currentLocation;
        _mapController.move(LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!), 13.0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320, // Largeur du conteneur rectangulaire
      height: 380, // Hauteur du conteneur rectangulaire
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color.fromARGB(255, 238, 54, 244), // Couleur des bordures
          width: 4, // Épaisseur des bordures
        ),
      ),
      child: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
