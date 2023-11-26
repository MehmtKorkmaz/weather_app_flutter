import 'package:flutter/material.dart';
import 'package:weatherappchallenge/views/widgets/animated_weather_icon.dart';

class InformationIcons extends StatefulWidget {
  final String icon;
  final String infoText;
  final String headText;
  const InformationIcons(
      {super.key,
      required this.icon,
      required this.infoText,
      required this.headText});

  @override
  State<InformationIcons> createState() => _InformationIconsState();
}

class _InformationIconsState extends State<InformationIcons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WeatherIcon(
          icon: widget.icon,
        ),
        Text(
          widget.headText,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          widget.infoText,
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    );
  }
}
