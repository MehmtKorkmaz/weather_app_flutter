import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherIcon extends StatefulWidget {
  final String icon;
  const WeatherIcon({super.key, required this.icon});

  @override
  State<WeatherIcon> createState() => _WeatherIconState();
}

class _WeatherIconState extends State<WeatherIcon>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Lottie.asset(
        'assets/icons/${widget.icon}.json',
        animate: true,
        repeat: true,
        reverse: true,
        fit: BoxFit.cover,
      ),
    );
  }
}
