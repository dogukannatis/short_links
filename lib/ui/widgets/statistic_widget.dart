import 'package:flutter/material.dart';

class StatisticWidget extends StatelessWidget {
  final String? headerString;
  final String? bodyString;
  const StatisticWidget({
    super.key,
    this.headerString,
    this.bodyString
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("$headerString", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 42),),
        Text("$bodyString", style: const TextStyle(fontSize: 38, letterSpacing: 3))
      ],
    );
  }
}