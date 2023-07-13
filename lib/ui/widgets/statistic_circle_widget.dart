import 'package:flutter/material.dart';

class StatisticCircleWidget extends StatelessWidget {
  final String? headerString;
  final String? bodyString;
  const StatisticCircleWidget({
    super.key,
    this.headerString,
    this.bodyString
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 60,
      child: CircleAvatar(
        backgroundColor: Colors.indigo,
        radius: 58,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("$headerString", style: const TextStyle(color: Colors.white, fontSize: 24, letterSpacing: 3),),
            Text("$bodyString", style: const TextStyle(color: Colors.white, fontSize: 24, letterSpacing: 3))
          ],
        ),
      ),
    );
  }
}