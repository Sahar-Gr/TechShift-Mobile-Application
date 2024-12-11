import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeBattery extends StatelessWidget {
  final double value;
  final String unit;

  const GaugeBattery({
    Key? key,
    required this.value,
    required this.unit,
  }) : super(key: key);

  Color _getColorForValue(double value) {
    if (value >= 75) {
      return Colors.greenAccent; // Vert néon
    } else if (value >= 30) {
      return Colors.amberAccent; // Jaune néon
    } else {
      return Colors.redAccent; // Rouge néon
    }
  }

  @override
  Widget build(BuildContext context) {
    Color gaugeColor = _getColorForValue(value);

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black.withOpacity(0.2), Colors.black.withOpacity(0.5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gaugeColor.withOpacity(0.6),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: SfLinearGauge(
        minimum: 0,
        maximum: 100,
        orientation: LinearGaugeOrientation.horizontal,
        majorTickStyle: LinearTickStyle(
          length: 10,
          color: Colors.white.withOpacity(0.6),
        ),
        axisLabelStyle: TextStyle(
          fontSize: 14.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Digital7',
        ),
        axisTrackStyle: LinearAxisTrackStyle(
          color: const Color.fromARGB(255, 104, 77, 77).withOpacity(0.3),
          edgeStyle: LinearEdgeStyle.bothFlat,
          thickness: 12.0,
          borderColor: Colors.black,
        ),
        ranges: <LinearGaugeRange>[
          LinearGaugeRange(
            startValue: 0,
            endValue: 100,
            color: gaugeColor.withOpacity(0.5),
          ),
        ],
        markerPointers: [
          LinearShapePointer(
            value: value,
            color: gaugeColor,
            height: 25,
            width: 25,
            position: LinearElementPosition.cross,
            borderWidth: 2,
            borderColor: Colors.white,
            shapeType: LinearShapePointerType.circle,
            animationDuration: 1000, // Animation de 1 seconde
          ),
        ],
        barPointers: [
          LinearBarPointer(
            value: value,
            color: gaugeColor,
            thickness: 5,
            edgeStyle: LinearEdgeStyle.bothFlat,
            animationDuration: 1000, // Animation de 1 seconde
          ),
        ],
      ),
    );
  }
}
