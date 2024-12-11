import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ClimatePage extends StatelessWidget {
  const ClimatePage({super.key, required this.value});
  final num value;
  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      innerWidget: (percentage) {
        return Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  percentage.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const Text(
                  "C",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      appearance: CircularSliderAppearance(
        customColors: CustomSliderColors(
          gradientEndAngle: 100,
          gradientStartAngle: 100,
          trackColors: [
            Colors.black,
            Colors.red,
            Colors.white,
            Colors.green,
            Colors.limeAccent,
            Colors.pinkAccent,
            Colors.red,
            Colors.white,
            Colors.green,
            Colors.limeAccent,
            Colors.pinkAccent,
            Colors.red,
            Colors.white,
            Colors.green,
            Colors.limeAccent,
            Colors.pinkAccent,
          ],
          shadowColor: Colors.blue,
          progressBarColors: [
            Colors.black,
            Colors.red,
            Colors.white,
            Colors.green,
            Colors.limeAccent,
            Colors.pinkAccent,
            Colors.red,
            Colors.white,
            Colors.green,
            Colors.limeAccent,
            Colors.pinkAccent,
            Colors.red,
            Colors.white,
            Colors.green,
            Colors.limeAccent,
            Colors.pinkAccent,
          ],
          shadowMaxOpacity: 10,
          dotColor: Colors.red,
          dynamicGradient: true,
        ),
        animationEnabled: true,
        counterClockwise: true,
        size: 280,
        spinnerMode: false,
        startAngle: 0,
        angleRange: 359,
      ),
      max: 100,
      min: 0.0,
      initialValue: value.toDouble(),
    );
  }
}
