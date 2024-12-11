import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeSpeed extends StatelessWidget {
  final String title;
  final String unit;
  final double min;
  final double max;
  final List<Color> colors;
  final double value;

  const GaugeSpeed({
    Key? key,
    required this.title,
    required this.unit,
    this.min = 0,
    this.max = 260,
    required this.colors,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double gaugeWidth = constraints.maxWidth;
        double valueFontSize = gaugeWidth * 0.15; // Ajuster la taille en fonction de la largeur de la gauge
        double unitFontSize = gaugeWidth * 0.08; // Ajuster la taille de l'unité

        return SfRadialGauge(
          enableLoadingAnimation: true,
          animationDuration: 4500,
          title: GaugeTitle(
            text: title,
            textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
            borderWidth: 3,
            alignment: GaugeAlignment.near,
          ),
          axes: [
            RadialAxis(
              minimum: min,
              maximum: max,
              ranges: [
                GaugeRange(
                  startValue: 111,
                  endValue: 260,
                  color: Colors.red,
                  startWidth:5,
                  endWidth: 5,
                ),
                GaugeRange(
                  startValue: 0,
                  endValue: 110, // Ajuster la plage en fonction des valeurs
                  color: Color.fromARGB(255, 3, 44, 251), // Couleur pour la plage inférieure
                  startWidth: 5,
                  endWidth:5,
                ),
              ],
              majorTickStyle: MajorTickStyle(
                length: 15,
                color: Colors.white,
                thickness: 2,
              ),
              minorTickStyle: MinorTickStyle(
                length: 10,
                color: Colors.white.withOpacity(0.5),
                thickness: 1,
              ),
              minorTicksPerInterval: 4,
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${value.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontFamily: 'Digital7',
                          fontSize: valueFontSize, // Taille dynamique pour la valeur
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        unit,
                        style: TextStyle(
                          fontFamily: 'Digital7',
                          fontSize: unitFontSize, // Taille dynamique pour l'unité
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  angle: 90,
                  positionFactor: 0.1,
                ),
              ],
              pointers: <GaugePointer>[
                MarkerPointer(
                  value: value,
                  markerHeight: 80,
                  markerWidth: 20,
                  elevation: 4,
                  color: Colors.white,
                  enableAnimation: true,
                  animationDuration: 1500,
                  animationType: AnimationType.ease,
                ),
                NeedlePointer(
                  value: value,
                  needleLength: 0.8,
                  enableAnimation: true,
                  animationDuration: 1500,
                  animationType: AnimationType.ease,
                  needleColor: Colors.transparent,
                  knobStyle: KnobStyle(
                    knobRadius: 0.05,
                    sizeUnit: GaugeSizeUnit.factor,
                    borderWidth: 0,
                    color: Colors.transparent,
                  ),
                ),
                RangePointer(
                  value: value,
                  color: Color.fromARGB(32, 3, 44, 251).withOpacity(0.3), // Couleur bleue avec transparence
                  enableAnimation: true,
                  animationDuration: 1500,
                  animationType: AnimationType.ease,
                  pointerOffset: 50,
                  width: 10, // Ajuster la largeur de l'ombre si nécessaire
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
